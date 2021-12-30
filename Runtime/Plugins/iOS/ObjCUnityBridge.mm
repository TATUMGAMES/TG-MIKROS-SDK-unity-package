//
//  ObjCUnityBridge.mm
//  mikros-framework-ios
//  Description: Bridging file to communicate C# with Swift via Obj-C.
//
#include <mikros_framework_ios/mikros_framework_ios-Swift.h>
#import <Foundation/Foundation.h>
#import <UnityFramework/UnityFramework-Swift.h>

#pragma mark - C interface

extern "C"
{
    /// Mikros Analytics initialization meta data/settings.
    /// @param apiKey Api key required for performing requests.
    /// @param baseUrl Base url to perform necessary requests.
    /// @param appGameId Issued unique identifier used to identify specific apps.
    /// @param apiKeyType Environment representation of apiKeys.
    /// @param deviceId Device unique identifier.
    /// @param appVersion Versioning for app releases and updates.
    /// @param sdkVersion Versioning for Mikros SDK releases and updates.
    void ClientConfigurationSetup(char* apiKey, char* baseUrl, char* appGameId, char* apiKeyType, char* deviceId, char* appVersion, char* sdkVersion, bool isEventLogging, bool isTrackUserSession) {
        NSString *strApiKey = [NSString stringWithUTF8String: apiKey];
        NSString *strBaseUrl = [NSString stringWithUTF8String: baseUrl];
        NSString *strAppGameId = [NSString stringWithUTF8String: appGameId];
        NSString *strApiKeyType = [NSString stringWithUTF8String: apiKeyType];
        NSString *strDeviceId = [NSString stringWithUTF8String: deviceId];
        NSString *strAppVersion = [NSString stringWithUTF8String: appVersion];
        NSString *strSdkVersion = [NSString stringWithUTF8String: sdkVersion];
        [[SwiftToUnity shared] clientConfigurationSetUpWithApiKey: strApiKey
                                                          baseUrl: strBaseUrl
                                                        appGameId: strAppGameId
                                                       apiKeyType: strApiKeyType
                                                         deviceId: strDeviceId
                                                       appVersion: strAppVersion
                                                       sdkVersion: strSdkVersion
                                                   isEventLogging: isEventLogging
                                               isTrackUserSession: isTrackUserSession];
    }
    /// Update user meatdata requests.
    /// @param latitude Latitude.
    /// @param longitude Longitude.
    /// @param deviceModel Device model.
    /// @param deviceOSVersion Operating System version of device.
    /// @param deviceOperatingSystem Operating System of device.
    /// @param deviceScreenDpi DPI of device's screen.
    /// @param deviceScreenHeight Height of device's screen.
    /// @param deviceScreenWidth Width of device's screen.
    /// @param sdkVersion Versioning for Mikros SDK releases and updates.
    /// @param sdkType Type of SDK being used.
    /// @param isWifi Status of internet connectivity.
    void UpdateUserMetadata(char* latitude, char* longitude, char* deviceModel, char* deviceOSVersion, char* deviceOperatingSystem, char* deviceScreenDpi, char* deviceScreenHeight, char* deviceScreenWidth, char* sdkVersion, char* sdkType, char* isWifi)
    {
        NSString *strLatitude = [NSString stringWithUTF8String: latitude];
        NSString *strLongitude = [NSString stringWithUTF8String: longitude];
        NSString *strDeviceModel = [NSString stringWithUTF8String: deviceModel];
        NSString *strDeviceOSVersion = [NSString stringWithUTF8String: deviceOSVersion];
        NSString *strDeviceOperatingSystem = [NSString stringWithUTF8String: deviceOperatingSystem];
        NSString *strDeviceScreenDpi = [NSString stringWithUTF8String: deviceScreenDpi];
        NSString *strDeviceScreenHeight = [NSString stringWithUTF8String: deviceScreenHeight];
        NSString *strDeviceScreenWidth = [NSString stringWithUTF8String: deviceScreenWidth];
        NSString *strSdkType = [NSString stringWithUTF8String: sdkType];
        NSString *strIsWifi = [NSString stringWithUTF8String: isWifi];
        [[SwiftToUnity shared] updateMetaDataWithLatitude: strLatitude
                                                longitude: strLongitude
                                              deviceModel: strDeviceModel
                                                 deviceOS: strDeviceOperatingSystem
                                          deviceOSVersion: strDeviceOSVersion
                                          deviceScreenDpi: strDeviceScreenDpi
                                       deviceScreenHeight: strDeviceScreenHeight
                                        deviceScreenWidth: strDeviceScreenWidth
                                                  sdkType: strSdkType
                                                   isWifi: strIsWifi];
    }

    /// Log Mikros Analytics event requests.
    /// @param eventData The event being tracked. This is represented as JSON string.
    void LogEvent(const char* eventData) {
        //NSString *strEventData = [NSString stringWithCString:eventData encoding:NSASCIIStringEncoding];
        NSString *strEventData = [NSString stringWithUTF8String: eventData];
        [[SwiftToUnity shared] logEventsWithEventData: strEventData];
    }

    /// Flush any init or error events in current queue; this will fire a one time task to flush events.
    void FlushEvents()
    {
        [[SwiftToUnity shared] flushEvents];
    }

    /// Used to update the value of session logging, allowing to enable or disable Mikros Analytics user sessions once the configuration has been set.
    /// @param isTrackUserSession Enable or disable Mikros Analytics session tracking.
    void UpdateSessionLogging(bool isTrackUserSession)
    {
        [[SwiftToUnity shared] updateSessionLoggingWithIsTrackUserSession: isTrackUserSession];
    }

    /// Used to update the value of event logging, allowing to enable or disable Mikros Analytics events once the configuration has been set.
    /// @param isEventLogging Enable or disable Mikros Analytics event tracking.
    void UpdateEventLogging(bool isEventLogging)
    {
        [[SwiftToUnity shared] updateEventLoggingWithIsEventLogging:isEventLogging];
    }

    /// Method used whenever a key, touch, or trackball event is dispatched to the activity.
    void OnMotionEvent()
    {
        [[SwiftToUnity shared] onMotionEvent];
    }
}
