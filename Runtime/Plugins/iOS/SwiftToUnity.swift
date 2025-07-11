//
//  SwiftToUnity.swift
//  mikros_framework_ios
//  Description: Bridging file to communicate Obj-C with Swift.

import Foundation
import mikros_framework_ios

@objc public class SwiftToUnity: NSObject {
    @objc public static let shared = SwiftToUnity()
    private override init() { }

    /// Mikros Analytics initialization meta data/settings.
    /// @param apiKey Api key required for performing requests.
    /// @param baseUrl Base url to perform necessary requests.
    /// @param appGameId Issued unique identifier used to identify specific apps.
    /// @param apiKeyType Environment representation of apiKeys.
    /// @param deviceId Device unique identifier.
    /// @param appVersion Versioning for app releases and updates.
    /// @param sdkVersion Versioning for Mikros SDK releases and updates.
    /// @param eventLogging Status of event logging.
    /// @param trackUserSession Status of user session tracking.
    /// @param crashReporting Status of crash reporting.
    @objc public func clientConfigurationSetUp(apiKey: String,
                                                baseUrl: String,
                                                appGameId: String,
                                                apiKeyType: String,
                                                deviceId: String,
                                                appVersion: String,
                                                sdkVersion: String,
                                                eventLogging: String,
                                                trackUserSession: String,
                                                crashReporting: String) {
        do {
            let cilentConfigBuilder = try ClientConfigurationBuilder()
                .set(apiKey: apiKey)
                .set(baseUrl: baseUrl)
                .set(appGameId: appGameId)
                .set(appVersion: appVersion)
                .set(sdkVersion: sdkVersion)
                .set(apiKeyType: apiKeyType)
                .set(deviceId: deviceId)
                .create()
            let analyticsBuilder = try AnalyticsConfigurationBuilder()
                .set(eventLogging: eventLogging == "1")
                .set(eventLogging: crashReporting == "1")
                .create()
            let sessionBuilder = try AnalyticsSessionConfigurationBuilder()
                .set(eventLogging: trackUserSession == "1")
                .create()
            try MikrosApiClientProvider.initialize(clientConfiguration: cilentConfigBuilder,
                                                   analyticsEventConfiguration: analyticsBuilder,
                                                   analyticsSessionConfiguration: sessionBuilder)
        } catch let error {
            print(error)
        }
    }

    /// Update user metadata requests.
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
    @objc public func updateMetaData(latitude: String,
                                     longitude: String,
									 deviceBattery: String,
                                     deviceModel: String,
                                     deviceOS: String,
                                     deviceOSVersion: String,
									 deviceOrientation:String,
                                     deviceScreenDpi: String,
                                     deviceScreenHeight: String,
                                     deviceScreenWidth: String,
                                     sdkType: String,
                                     isWifi: String) {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            let updateMetaDataBuilder = try UserMetadataBuilder()
                .set(latitude: latitude)
                .set(longitude: longitude)
				.set(deviceBattery: deviceBattery)
                .set(deviceModel: deviceModel)
                .set(deviceOS: deviceOS)
                .set(deviceOSVersion: deviceOSVersion)
				.set(deviceOrientation:deviceOrientation)
                .set(deviceScreenDpi: deviceScreenDpi)
                .set(deviceScreenHeight: deviceScreenHeight)
                .set(deviceScreenWidth: deviceScreenWidth)
                .set(sdkType: sdkType)
                .set(isWifi: isWifi)
                .create()
            mikrosApiClientProvider.updateUserMetadata(userMetadata: updateMetaDataBuilder)
        } catch let error {
            print(error)
        }
    }
    
	/// Update DeviceId requests.
    /// @param deviceId.
    @objc public func updateUserDeviceId(deviceId : NSString)
    {
        do{
            let strDeviceId = String(deviceId)
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.updateDeviceId(deviceId: strDeviceId)
        }
        catch let error
        {
            print(error)
        }
    }

    /// Log Mikros Analytics event requests.
    /// @param eventData The event being tracked. This is represented as JSON string.
    @objc public func logEvents(eventData: NSString) {
        do {
            let strEventData = String(eventData)
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            let mikrosEvent = try MikrosEventBuilder()
                .set(event: strEventData)
                .create()
            mikrosApiClientProvider.logEvent(mikrosEvent)
        } catch let error {
            print(error)
        }
    }

    /// Flush any init or error events in current queue; this will fire a one time task to flush events.
    @objc public func flushEvents() {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.flushEvents()
        } catch let error {
            print(error)
        }
    }

    /// Used to update the value of session logging, allowing to enable or disable Mikros Analytics user sessions once the configuration has been set.
    /// @param isTrackUserSession Enable or disable Mikros Analytics session tracking.
    @objc public func updateSessionLogging(isTrackUserSession: Bool) {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.updateSessionLogging(isEnabled: isTrackUserSession)
        } catch let error {
            print(error)
        }
    }

    /// Used to update the value of event logging, allowing to enable or disable Mikros Analytics events once the configuration has been set.
    /// @param isEventLogging Enable or disable Mikros Analytics event tracking.
    @objc public func updateEventLogging(isEventLogging: Bool) {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.updateEventLogging(isEnabled: isEventLogging)
        } catch let error {
            print(error)
        }
    }
    
    /// Used to set the status of crash reporting.
    /// @param isCrashReportingEnabled Enable or disable Mikros Crash Reporting.
    @objc public func updateCrashReporting(isCrashReportingEnabled: Bool) {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.updateCrashEventLogging(isEnabled: isCrashReportingEnabled)
        } catch let error {
            print(error)
        }
    }

    /// Method used whenever a key, touch, or trackball event is dispatched to the activity.
    @objc public func onMotionEvent() {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.onMotionEvent()
        } catch let error {
            print(error)
        }
    }

    /// Used to set the status of Memory Logging.
    /// @param isEventLogging Enable or disable Mikros Memory Logging.
    @objc public func updateMemoryLogging(isEventLogging: Bool) {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.updateMemoryLogging(isEnabled: isEventLogging)
        } catch let error {
            print(error)
        }
    }
    
    /// Used to flush memory event.
    @objc public func flushMemoryEvents() {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.flushMemoryEvents()
        } catch let error {
            print(error)
        }
    }

    /// Used to flush session event.
    @objc public func flushSessionEvents() {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.flushSessionEvents()
        } catch let error {
            print(error)
        }
    }
    
    /// Used to flush gameplay event.
    @objc public func flushGameplayEvents() {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.flushGameplayEvents()
        } catch let error {
            print(error)
        }
    }
}
