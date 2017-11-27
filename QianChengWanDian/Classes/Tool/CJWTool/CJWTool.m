//
//  CJWTool.m
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWTool.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation CJWTool

SingletonImplementation(Tool)


+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}


+ (NSString *)getDeviceIdentifier
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    NSString *identifierNumber = [SSKeychain passwordForService:CJW_B2C_SERVER_NAME account:@"user"];
    
    if (!identifierNumber){
        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", uuidStr] forService:CJW_B2C_SERVER_NAME account:@"user"];
        identifierNumber = [SSKeychain passwordForService:CJW_B2C_SERVER_NAME account:@"user"];
    }
    

   
    return identifierNumber;
    
}

@end
