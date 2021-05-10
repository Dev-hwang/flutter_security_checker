//
//  JailBreakChecker.m
//  flutter_security_checker
//
//  Created by WOO JIN HWANG on 2021/05/07.
//

#import <Foundation/Foundation.h>
#import "JailBreakChecker.h"

@implementation JailBreakChecker
+ (BOOL)isJailBroken {
  if (access("/Applications/Cydia.app", F_OK) != -1
      || access("/Applications/crackerxi.app", F_OK) != -1
      || access("/Applications/CrackerXI+.app", F_OK) != -1
      || access("/var/lib/apt", F_OK) != -1
      || access("/var/lib/cydia", F_OK) != -1
      || access("/private/var/lib/apt", F_OK) != -1
      || access("/private/var/lib/cydia", F_OK) != -1
      || access("/private/var/tmp/cydia.log", F_OK) != -1
      || access("/private/var/tmp/frida-*.dylib", F_OK) != -1
      || access("/private/var/stash", F_OK) != -1
      || access("/usr/bin/sshd", F_OK) != -1
      || access("/usr/sbin/sshd", F_OK) != -1
      || access("/usr/sbin/frida-server", F_OK) != -1
      || access("/usr/libexec/sftp-server", F_OK) != -1
      || access("/usr/libexec/ssh-keysign", F_OK) != -1
      || access("/usr/libexec/cydia/firmware.sh", F_OK) != -1
      || access("/Library/MobileSubstrate/MobileSubstrate.dylib", F_OK) != -1
      || access("/Library/MobileSubstrate/DynamicLibraries/*", F_OK) != -1
      || access("/System/Library/LaunchDaemons/com.ikey.bbot.plist", F_OK) != -1
      || access("/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist", F_OK) != -1
      || access("/bin/sh", F_OK) != -1
      || access("/bin/bash", F_OK) != -1
      || access("/etc/apt/sources.list.d/cydia.list", F_OK) != -1
      || access("/etc/ssh/sshd_config", F_OK) != -1
      || access("/etc/apt", F_OK) != -1) {
    return YES;
  }
  
  NSError *error = nil;
  NSString *string = @"jailbreak test";
  [string writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
  
  if (error == nil) {
    return YES;
  } else {
    [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
  }
  
  if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
    return YES;
  }
  
  return NO;
}
@end
