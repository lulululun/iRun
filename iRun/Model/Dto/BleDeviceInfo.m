//
//  BleDeviceInfo.m
//  iRun
//
//  Created by izhangyb on 16/4/27.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "BleDeviceInfo.h"

@implementation BleDeviceInfo

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.deviceId forKey:@"deviceId"];
    [encoder encodeObject:self.deviceSn forKey:@"deviceSn"];
    [encoder encodeObject:self.deviceName forKey:@"deviceName"];
    [encoder encodeObject:self.modelNumber forKey:@"modelNumber"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.broadcastId forKey:@"broadcastId"];
    [encoder encodeObject:self.protocolType forKey:@"protocolType"];
    [encoder encodeObject:self.preparePair forKey:@"preparePair"];
    [encoder encodeObject:self.deviceType forKey:@"deviceType"];
    [encoder encodeObject:self.supportDownloadInfoFeature forKey:@"supportDownloadInfoFeature"];
    [encoder encodeObject:self.maxUserQuantity forKey:@"maxUserQuantity"];
    [encoder encodeObject:self.softwareVersion forKey:@"softwareVersion"];
    [encoder encodeObject:self.hardwareVersion forKey:@"hardwareVersion"];
    [encoder encodeObject:self.firmwareVersion forKey:@"firmwareVersion"];
    [encoder encodeObject:self.manufactureName forKey:@"manufactureName"];
    [encoder encodeObject:self.systemId forKey:@"systemId"];
    [encoder encodeObject:self.peripheralIdentifier forKey:@"peripheralIdentifier"];
    [encoder encodeObject:self.deviceUserNumber forKey:@"deviceUserNumber"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.deviceId = [decoder decodeObjectForKey:@"deviceId"];
        self.deviceSn = [decoder decodeObjectForKey:@"deviceSn"];
        self.deviceName = [decoder decodeObjectForKey:@"deviceName"];
        self.modelNumber = [decoder decodeObjectForKey:@"modelNumber"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.broadcastId = [decoder decodeObjectForKey:@"broadcastId"];
        self.protocolType = [decoder decodeObjectForKey:@"protocolType"];
        self.preparePair = [decoder decodeObjectForKey:@"preparePair"];
        self.deviceType = [decoder decodeObjectForKey:@"deviceType"];
        self.supportDownloadInfoFeature = [decoder decodeObjectForKey:@"supportDownloadInfoFeature"];
        self.maxUserQuantity = [decoder decodeObjectForKey:@"maxUserQuantity"];
        self.softwareVersion = [decoder decodeObjectForKey:@"softwareVersion"];
        self.hardwareVersion = [decoder decodeObjectForKey:@"hardwareVersion"];
        self.firmwareVersion = [decoder decodeObjectForKey:@"firmwareVersion"];
        self.manufactureName = [decoder decodeObjectForKey:@"manufactureName"];
        self.systemId = [decoder decodeObjectForKey:@"systemId"];
        self.peripheralIdentifier = [decoder decodeObjectForKey:@"peripheralIdentifier"];
        self.deviceUserNumber = [decoder decodeObjectForKey:@"deviceUserNumber"];
    }
    return  self;
}

@end
