//
//  IntegrityChecker.m
//  flutter_security_checker
//
//  Created by WOO JIN HWANG on 2021/05/07.
//

#import <Foundation/Foundation.h>
#import <mach-o/fat.h>
#import <mach-o/loader.h>
#import "IntegrityChecker.h"

@implementation IntegrityChecker
+ (BOOL)isBinaryEncrypted {
  const struct mach_header *machHeader;
  struct load_command *loadCommand = nil;

  NSString *execPath = [[NSBundle mainBundle] executablePath];
  NSData *fileData = [NSData dataWithContentsOfFile:execPath];
  char *binaryBase = (char *)[fileData bytes];

  machHeader = (const struct mach_header *)binaryBase;
  
  if (machHeader->magic == FAT_CIGAM) {
    unsigned int offset = 0;
    struct fat_arch *fatArch = (struct fat_arch *)((struct fat_header *)machHeader + 1);
    struct fat_header *fatHeader = (struct fat_header *)machHeader;
      
    for (uint32_t i=0; i<ntohl(fatHeader->nfat_arch); i++) {
      if (sizeof(int *) == 4 && !(ntohl(fatArch->cputype) & CPU_ARCH_ABI64)) {
        offset = ntohl(fatArch->offset);
        break;
      } else if (sizeof(int *) == 8 && (ntohl(fatArch->cputype) & CPU_ARCH_ABI64)) {
        offset = ntohl(fatArch->offset);
        break;
      }
        
      fatArch = (struct fat_arch *)((uint8_t *)fatArch + sizeof(struct fat_arch));
    }
      
    machHeader = (const struct mach_header *)((uint8_t *)machHeader + offset);
  }
  
  if (machHeader->magic == MH_MAGIC) {
    loadCommand = (struct load_command *)((struct mach_header *)machHeader + 1);
  } else if (machHeader->magic == MH_MAGIC_64) {
    loadCommand = (struct load_command *)((struct mach_header_64 *)machHeader + 1);
  }
  
  for (uint32_t i=0; i<machHeader->ncmds && loadCommand != nil; i++) {
    if (loadCommand->cmd == LC_ENCRYPTION_INFO) {
      struct encryption_info_command *cryptCmd = (struct encryption_info_command *)loadCommand;
      return cryptCmd->cryptid;
    }
    
    if (loadCommand->cmd == LC_ENCRYPTION_INFO_64) {
      struct encryption_info_command_64 *cryptCmd = (struct encryption_info_command_64 *)loadCommand;
      return cryptCmd->cryptid;
    }
      
    loadCommand = (struct load_command *)((uint8_t *)loadCommand + loadCommand->cmdsize);
  }
  
  return NO;
}
@end
