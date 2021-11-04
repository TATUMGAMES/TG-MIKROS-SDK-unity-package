//
//  ObjCUnityBridge.mm
//  mikros-framework-ios
//  Description: Bridging file to communicate C# with Swift.
//
#include <Mikros/Mikros-Swift.h>
#import <Foundation/Foundation.h>

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
    void ClientConfigurationSetup(char* apiKey, char* baseUrl, char* appGameId, char* apiKeyType, char* deviceId, char* appVersion, char* sdkVersion, bool isEventLogging, bool isTrackUserSession)
    {
        // Creating clientConfiguration object.
        ClientConfigurationBuilder *clientConfigurationBuilder = [[ClientConfigurationBuilder alloc] init];
        [clientConfigurationBuilder setWithApiKey:[NSString stringWithUTF8String:apiKey] ];
        [clientConfigurationBuilder setWithBaseUrl:[NSString stringWithUTF8String:baseUrl] ];
        [clientConfigurationBuilder setWithAppGameId:[NSString stringWithUTF8String:appGameId] ];
        [clientConfigurationBuilder setWithApiKeyType:[NSString stringWithUTF8String:apiKeyType] ];
        [clientConfigurationBuilder setWithDeviceId:[NSString stringWithUTF8String:deviceId]];
        [clientConfigurationBuilder setWithAppVersion:[NSString stringWithUTF8String:appVersion]];
        [clientConfigurationBuilder setWithSdkVersion:[NSString stringWithUTF8String:sdkVersion]];
        
        NSError *clientConfigurationError = nil;
        ClientConfiguration *clientConfiguration = [clientConfigurationBuilder createAndReturnError:&clientConfigurationError];
        
        // Creating analyticsConfiguration instance.
        AnalyticsConfigurationBuilder *analyticsConfigurationBuilder = [[AnalyticsConfigurationBuilder alloc] init];
        [analyticsConfigurationBuilder setWithEventLogging:isEventLogging];
        
        NSError *analyticsConfigurationError = nil;
        AnalyticsEventConfiguration *analyticsEventConfiguration = [analyticsConfigurationBuilder createAndReturnError:&analyticsConfigurationError];
        
        // Creating analyticsSessionConfiguration object.
        AnalyticsSessionConfigurationBuilder *analyticsSessionConfigurationBuilder = [[AnalyticsSessionConfigurationBuilder alloc] init];
        [analyticsSessionConfigurationBuilder setWithEventLogging:isTrackUserSession];
        
        NSError *analyticsSessionConfigurationError = nil;
        AnalyticsSessionConfiguration *analyticsSessionConfiguration = [analyticsSessionConfigurationBuilder createAndReturnError:&analyticsSessionConfigurationError];
        
        // Setting up MikrosApiClientProvider object.
        NSError *clientProviderError = nil;
        [MikrosApiClientProvider initializeWithClientConfiguration:clientConfiguration analyticsEventConfiguration:analyticsEventConfiguration analyticsSessionConfiguration:analyticsSessionConfiguration error:&clientProviderError];
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
		
	}

    /// Log Mikros Analytics event requests.
    /// @param eventData The event being tracked. This is represented as JSON string.
    void LogEvent(char* eventData)
    {
        NSError *apiClientError = nil;
        MikrosApiClient *mikrosApiClient = [MikrosApiClientProvider getInstanceAndReturnError:&apiClientError];
        
        // Setting the event.
        MikrosEventBuilder *mikrosEventBuilder = [[MikrosEventBuilder alloc]init];
        [mikrosEventBuilder setWithEvent:[NSString stringWithUTF8String: eventData]];
        
        NSError *eventBuilderError = nil;
        MikrosEvent *mikrosEvent = [mikrosEventBuilder createAndReturnError:&eventBuilderError];
        
        // Logging the event.
        [mikrosApiClient logEvent:mikrosEvent];
    }

    /// Flush any init or error events in current queue; this will fire a one time task to flush events.
    void FlushEvents()
    {
        NSError *apiClientError = nil;
        MikrosApiClient *mikrosApiClient = [MikrosApiClientProvider getInstanceAndReturnError:&apiClientError];
        [mikrosApiClient flushEvents];
    }

    /// Used to update the value of session logging, allowing to enable or disable Mikros Analytics user sessions once the configuration has been set.
    /// @param isTrackUserSession Enable or disable Mikros Analytics session tracking.
    void UpdateSessionLogging(bool isTrackUserSession)
    {
        NSError *apiClientError = nil;
        MikrosApiClient *mikrosApiClient = [MikrosApiClientProvider getInstanceAndReturnError:&apiClientError];
        [mikrosApiClient updateSessionLoggingWithIsEnabled:isTrackUserSession];
    }

    /// Used to update the value of event logging, allowing to enable or disable Mikros Analytics events once the configuration has been set.
    /// @param isEventLogging Enable or disable Mikros Analytics event tracking.
    void UpdateEventLogging(bool isEventLogging)
    {
        NSError *apiClientError = nil;
        MikrosApiClient *mikrosApiClient = [MikrosApiClientProvider getInstanceAndReturnError:&apiClientError];
        [mikrosApiClient updateEventLoggingWithIsEnabled:isEventLogging];
    }

    /// Method used whenever a key, touch, or trackball event is dispatched to the activity.
    void OnMotionEvent()
    {
        NSError *apiClientError = nil;
        MikrosApiClient *mikrosApiClient = [MikrosApiClientProvider getInstanceAndReturnError:&apiClientError];
        [mikrosApiClient onMotionEvent];
    }
}
