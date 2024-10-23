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
  // check jailBreak apps
  if (access("/Applications/Cydia.app", F_OK) != -1
      || access("/Applications/crackerxi.app", F_OK) != -1
      || access("/Applications/CrackerXI+.app", F_OK) != -1
      || access("/Applications/FlyJB.app", F_OK) != -1
      || access("/Applications/blackra1n.app", F_OK) != -1
      || access("/Applications/Sileo.app", F_OK) != -1
      || access("/Applications/A-Bypass.app", F_OK) != -1
      || access("/Applications/FakeCarrier.app", F_OK) != -1
      || access("/Applications/Icy.app", F_OK) != -1
      || access("/Applications/MxTube.app", F_OK) != -1
      || access("/Applications/RockApp.app", F_OK) != -1
      || access("/Applications/SBSettings.app", F_OK) != -1
      || access("/Applications/WinterBoard.app", F_OK) != -1
      || access("/Applications/IntelliScreen.app", F_OK) != -1) {
    return YES;
  }
  
  // check jailBreak files
  if (access("/var/lib/apt", F_OK) != -1
      || access("/var/lib/cydia", F_OK) != -1
      || access("/usr/libexec/cydia/firmware.sh", F_OK) != -1
      || access("/private/var/stash", F_OK) != -1
      || access("/private/var/lib/apt", F_OK) != -1
      || access("/private/var/lib/cydia", F_OK) != -1
      || access("/private/var/tmp/cydia.log", F_OK) != -1
      || access("/private/var/mobile/Library/SBSettings/Themes", F_OK) != -1
      || access("/Library/MobileSubstrate/MobileSubstrate.dylib", F_OK) != -1
      || access("/Library/MobileSubstrate/DynamicLibraries/*", F_OK) != -1
      || access("/System/Library/LaunchDaemons/com.ikey.bbot.plist", F_OK) != -1
      || access("/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist", F_OK) != -1
      || access("/etc/apt/sources.list.d/cydia.list", F_OK) != -1
      || access("/etc/apt", F_OK) != -1
      || access("/usr/share/jailbreak/injectme.plist", F_OK) != -1 // unc0ver
      || access("/etc/apt/undecimus/undecimus.list", F_OK) != -1
      || access("/jb/offsets.plist", F_OK) != -1
      || access("/jb/jailbreakd.plist", F_OK) != -1
      || access("/jb/amfid_payload.dylib", F_OK) != -1
      || access("/jb/libjailbreak.dylib", F_OK) != -1
      || access("/.cydia_no_stash", F_OK) != -1
      || access("/.installed_unc0ver", F_OK) != -1
      || access("/usr/sbin/frida-server", F_OK) != -1 // frida
      || access("/private/var/tmp/frida-*.dylib", F_OK) != -1
      || access("/usr/lib/libjailbreak.dylib", F_OK) != -1 // electra
      || access("/etc/apt/sources.list.d/electra.list", F_OK) != -1
      || access("/etc/apt/sources.list.d/sileo.sources", F_OK) != -1
      || access("/jb/lzma", F_OK) != -1
      || access("/.bootstrapped_electra", F_OK) != -1
      || access("/var/mobile/Library/Preferences/ABPattern", F_OK) != -1 // A-Bypass
      || access("/usr/lib/ABDYLD.dylib", F_OK) != -1
      || access("/usr/lib/ABSubLoader.dylib", F_OK) != -1) {
    return YES;
  }
  
  // check simulator
  if (access("/bin/sh", F_OK) != -1
      || access("/bin/bash", F_OK) != -1
      || access("/usr/bin/ssh", F_OK) != -1
      || access("/usr/sbin/sshd", F_OK) != -1
      || access("/usr/libexec/sftp-server", F_OK) != -1
      || access("/usr/libexec/ssh-keysign", F_OK) != -1
      || access("/etc/ssh/sshd_config", F_OK) != -1) {
    return YES;
  }
  
  // check sendbox
  NSError *error = nil;
  NSString *stringToBeWritten = @"jailbreak test";
  NSString *filePath = @"/private/jailbreak.txt";
  [stringToBeWritten writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
  
  if (error == nil) {
    return YES;
  } else {
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
  }
  
  // check protocol handlers
  if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
    return YES;
  }
  
  return NO;
}
@end
