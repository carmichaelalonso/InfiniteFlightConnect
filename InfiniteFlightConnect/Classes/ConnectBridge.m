//
//  ConnectBridge.m
//  LiveFlight
//
//  Created by Cameron Carmichael Alonso on 10/08/2018.
//  Copyright © 2018 LiveFlight. All rights reserved.
//

#import "ConnectBridge.h"

@implementation ConnectBridge

-(size_t)sizeOf:(UInt8)value {
    return sizeof(value);
}

+(NSMutableData *)prepareDataForString:(NSString *)string {
    
    NSData *            stringData;
    NSUInteger          stringLength;
    union {
        uint32_t    u32;
        uint8_t     u8s[4];
    } lengthConverter;
    
    NSMutableData *result;
    //__Check_Compile_Time(sizeof(lengthConverter) == 4);
    
    stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    stringLength = stringData.length;
    assert(stringLength < ((NSUInteger) 1 * 1024 * 1024 * 1024));   // 1 GiB
    lengthConverter.u32 = OSSwapHostToLittleInt32(stringLength);
    
    result = [[NSMutableData alloc] init];
    size_t size = sizeof(lengthConverter.u8s);
    [result appendBytes:&lengthConverter.u8s length:size];
    [result appendData:stringData];
    
    return result;
    
}

@end
