//
//  SwiftToUnity.swift
//  mikros_framework_ios
//  Description: Bridging file to communicate Obj-C with Swift.

import Foundation
import mikros_framework_ios

@objc public class SwiftToUnity: NSObject {
    @objc public static let shared = SwiftToUnity()
    private var eventJsonString = ""
    private var keyStr = ""
    private var valueStr = ""
    private override init() { }

    /// Mikros Analytics initialization meta data/settings.
    /// @param apiKey Api key required for performing requests.
    /// @param baseUrl Base url to perform necessary requests.
    /// @param appGameId Issued unique identifier used to identify specific apps.
    /// @param apiKeyType Environment representation of apiKeys.
    /// @param deviceId Device unique identifier.
    /// @param appVersion Versioning for app releases and updates.
    /// @param sdkVersion Versioning for Mikros SDK releases and updates.
    @objc public  func clientConfigurationSetUp(apiKey: String,
                                                baseUrl: String,
                                                appGameId: String,
                                                apiKeyType: String,
                                                deviceId: String,
                                                appVersion: String,
                                                sdkVersion: String,
                                                isEventLogging: Bool,
                                                isTrackUserSession: Bool) {
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
                .set(eventLogging: isEventLogging)
                .create()
            let sessionBuilder = try AnalyticsSessionConfigurationBuilder()
                .set(eventLogging: isTrackUserSession)
                .create()
            try MikrosApiClientProvider.initialize(clientConfiguration: cilentConfigBuilder,
                                                   analyticsEventConfiguration: analyticsBuilder,
                                                   analyticsSessionConfiguration: sessionBuilder)
        } catch let error {
            print(error)
        }
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
    @objc public func updateMetaData(latitude: String,
                                     longitude: String,
                                     deviceModel: String,
                                     deviceOS: String,
                                     deviceOSVersion: String,
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
                .set(deviceModel: deviceModel)
                .set(deviceOS: deviceOS)
                .set(deviceOSVersion: deviceOSVersion)
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

    /// Convert a JSON string to dictionary.
    /// - Parameter text: JSON string.
    /// - Returns: Dictionary containing data in JSON as key-value pair.
    func convertToDictionary(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    /// Convert a dictionary to JSON by string concatenation method.
    /// - Parameter dictionary: Dictionary data.
    /// - Returns: JSON string created by concatenation.
    func dictToJsonString(dictionary: [String: String]) -> String? {
        eventJsonString = "{"
        for (key, value) in dictionary {
            keyStr = key
            valueStr = value
            eventJsonString += "\"" + keyStr + "\":\"" + valueStr + "\","
        }
        eventJsonString += "}"
        return eventJsonString
    }

    /// Log Mikros Analytics event requests.
    /// @param eventData The event being tracked. This is represented as JSON string.
    @objc public func logEvents(eventData: String) {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            guard let event = convertToDictionary(text: eventData),
                  let json = dictToJsonString(dictionary: event) else { return }
            let mikrosEvent = try MikrosEventBuilder()
                .set(event: json)
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

    /// Method used whenever a key, touch, or trackball event is dispatched to the activity.
    @objc public func onMotionEvent() {
        do {
            let mikrosApiClientProvider = try MikrosApiClientProvider.getInstance()
            mikrosApiClientProvider.onMotionEvent()
        } catch let error {
            print(error)
        }
    }
}
