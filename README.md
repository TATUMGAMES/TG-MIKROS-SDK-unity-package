## Table of Contents

* [What is MIKROS?](#what-is-mikros)
* [How Does MIKROS Work?](#how-does-mikros-work)
* [Installation](#installation)
* [How to Implement MIKROS?](#how-to-implement-mikros)
* [SDK Initialization](#sdk-initialization)
* [Privacy Standard](#privacy-standard)
* [Mikros Analytics](#mikros-analytics)
    * [Preset Analytics Events](#mikros-analytics-preset)    
	* [Custom Analytics Events](#mikros-analytics-custom)
* [Mikros Authentication](#mikros-authentication)
* [Mikros SSO](#mikros-sso)
* [Reputation Scoring](#reputation-scoring)
* [Mikros Button](#mikros-button)
* [FAQ](*faq)



<a name="what-is-mikros"></a>
## What Is MIKROS?
MIKROS is a service aimed at game developers which provides useful information and clear analytics in a sharing ecosystem, also known as data pooling. These insights about user behaviour can help developers understand their clientele better including their spending habits. MIKROS uniquely displays its analytics in a simple format with the goal of connecting game developers and advertisers to a full understanding of the problems they are looking to solve. This is due to all the data being in the MIKROS ecosystem.

<a name="how-does-mikros-work"></a>
## How Does MIKROS Work?
MIKROS sorts users by spending and activity levels in its ecosystem. This differs from how data is currently managed by competitors as they do not offer any data pooling. Game developers and advertisers can then view reports in a dashboard with valuable information which is needed to identify areas to improve their customer experience. With MIKROS, advertisers can now be certain that their ads are being shown to verified spenders.

<a name="installation"></a>
## Installation
### Installation via Git in UPM

You can install via Git. This assumes you have Git installed on your
computer.

In later versions of Unity, you can import directly via the Package Manager
interface.

![UPM, add from Git URL dropdown](Documentation/upm-via-git.png)

Supply the following URL:

```
https://github.com/TATUMGAMES/TG-MIKROS-SDK-unity-package.git
```

<a name="how-to-implement-mikros"></a>
## How to Implement MIKROS?
1. In order to use Mikros, clients (game developers/publishers) must go to https://developer.tatumgames.com/
2. Select a subscription plan. The options are FREE, STARTUP, ENTERPRISE
3. Register an account, and verify this account via email
4. Once inside the Mikros dashboard, the client can "create app". The process of creating an app is filling out a form that includes details such as company name, game title, description, package name (bundle id), product assets, videos, category {RPG, Puzzle, Platformer, CCG, Strategy, Other}

Once steps 1-4 is completed, the following will be generated:
1. App Game ID (auto-generated)
2. Production API Key (auto-generated)
3. QA API Key (Manual)
4. Development API Key (Manual)

Now, the client has to include the Mikros SDK into their gaming product and setup the SDK by the following method:
1. In the Unity Editor, select **Mikros > Edit Settings**
2. In the Inspector tab of **Mikros Settings**, paste in your App Game ID and API keys that have been generated.
3. *(Optional)* If you want manual initialization of the SDK, disable the ***Auto Initialize At Start*** option from the Mikros Settings. By default, it is kept enabled.
4. *(Optional)* You also have the option to select which API key to use at any development stage. By default, Production API Key is used.
5. *(Optional)* Mikros collects and sends session data for better user insights and is also crucial for Analytics purpose. This can be enabled or disabled by the ***Auto Track User Session*** option from the Mikros Settings. By default, it is kept enabled and is recommended to keep it that way.
6. *(Optional)* Mikros collects and sends metadata for better user insights and is also crucial for Analytics purpose. This can be enabled or disabled by the ***Auto Track User Metadata*** option from the Mikros Settings. By default, it is kept enabled and is recommended to keep it that way.

<a name="sdk-initialization"></a>
### SDK Initialization

Mikros SDK is initialized automatically by default. But you can manually initialize at any point in the following way:

Make sure to have the following namespaces defined at the top of your scripts:
```
using MikrosClient;
```

##### Initialize with Privacy Level set in Mikros Settings
```
MikrosManager.Instance.InitializeMikrosSDK();
```
##### Initialize with Privacy Level

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
|privacyLevel            | PRIVACY_LEVEL           | Required   |
```
Configuration configuration = Configuration.Builder().SetPrivacyLevel(privacyLevel).Create();
MikrosManager.Instance.InitializeMikrosSDK(configuration);
```
##### Initialize with custom Privacy Level

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
|privacyLevel            | PRIVACY_LEVEL           | Required   |
|isTrackSession          | Boolean                 | Required   |
|isTrackMetadata         | Boolean                 | Required   |
|isLogEvent              | Boolean                 | Required   |
|isCrashTracking         | Boolean                 | Required   |
|isTrackDeviceMemory     | Boolean                 | Required   |

```
Configuration configuration = Configuration.Builder().SetPrivacyLevel(privacyLevel)
			.SetSessionTracking(isTrackSession) 
			.SetMetadataTracking(isTrackMetadata)
			.SetEventLogging(isLogEvent)
			.SetCrashReporting(isCrashTracking)
			.SetTrackDeviceMemory(isTrackDeviceMemory)
			.Create();
MikrosManager.Instance.InitializeMikrosSDK(configuration);
```
With the above, users can do any permutation which is the advantage of using a Builder. For examples,
```
    Configuration.Builder().SetPrivacyLevel(privacyLevel)
   .Create();
```
   OR
 ```  
Configuration.Builder().SetPrivacyLevel(privacyLevel)
   .SetSessionTracking(isTrackSession) // boolean true/false
   .Create();
``` 
 OR
``` 
Configuration.Builder().SetPrivacyLevel(privacyLevel)
   .SetMetadataTracking(isTrackMetadata) // boolean true/false
   .Create();
 ```
   OR
```   
Configuration.Builder().SetPrivacyLevel(privacyLevel)
   .SetEventLogging(isLogEvent) // boolean true/false
   .Create();
```
   OR
```
 Configuration.Builder().SetPrivacyLevel(privacyLevel)
   .SetSessionTracking(isTrackSession) // boolean true/false
   .SetMetadataTracking(isTrackMetadata) // boolean true/false
   .Create();
```
   OR
```
Configuration.Builder().SetPrivacyLevel(privacyLevel)
   .SetCrashReporting(isCrashTracking) // boolean true/false
   .SetTrackDeviceMemory(isTrackDeviceMemory) // boolean true/false
   .Create();
```
   OR
```
Configuration.Builder().SetSessionTracking(isTrackSession)
   .Create();
```
 OR
```
Configuration.Builder() .SetTrackDeviceMemory(isTrackDeviceMemory)
   .Create();
```

*Note: The privacy configuration that is set in MikrosSettings from Editor, will always get overriden whenever a Configuration parameter is passed to the `MikrosManager.Instance.InitializeMikrosSDK` method.*


You can use the `MikrosManager.Instance` and request objects to perform any operation. You will also need to pass in the correct response callbacks.

<a name="privacy-standard"></a>
### Privacy Standard

Mikros provides 3 levels of privacy, all of which are GDPR & CCPA compliant. Following is the description for each privacy level:
1. PRIVACY_LEVEL.DEFAULT
   (Recommended) Mikros tracks user metadata and session in the background.

2. PRIVACY_LEVEL.HIGH
   Mikros no longer tracks any metadata information in the background; only session is tracked.

3. PRIVACY_LEVEL.EXTREME
   Mikros no longer tracks any metadata or session in the background. You will have to track manually.

However, Mikros also provides interfaces to set privacy standards according to requirement. This can be done as follows:

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| isTrackUserSession     | Boolean                 | Required   |
| isTrackUserMetadata    | Boolean                 | Required   |
| isEventLogging         | Boolean                 | Required   |
| isCrashReporting       | Boolean                 | Required   |
| isTrackDeviceMemory    | Boolean                 | Required   |

```
MikrosManager.Instance.ConfigurationController.SetAutoTrackUserSession(isTrackUserSession);
MikrosManager.Instance.ConfigurationController.SetAutoTrackUserMetadata(isTrackUserMetadata);
MikrosManager.Instance.ConfigurationController.SetEventLogging(isEventLogging);
MikrosManager.Instance.ConfigurationController.SetAutoCrashReporting(isCrashReporting);
MikrosManager.Instance.ConfigurationController.SetAutoTrackDeviceMemory(isTrackDeviceMemory);
```

If at any point it is required to customize logging of all type of user activity tracking (preset events, custom events, metadata, session), it can be done as follows:

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| isAllTrackingEnabled   | Boolean                 | Required   |
```
MikrosManager.Instance.ConfigurationController.SetAllTrackingEnabled(isAllTrackingEnabled);
```
<a name="mikros-analytics"></a>
### Mikros Analytics
Once the SDK is initialized, you can immediately start logging events (preset or custom) for analytics.

Make sure to have the following namespaces defined at the top of your scripts:
```
using MikrosClient;
using MikrosClient.Analytics;
```

<a name="mikros-analytics-preset"></a>
### Preset Analytics Events

##### Track Game Over Request Object

```
TrackGameOverRequest.Builder()
    .Create(
    trackGameOverRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackGameOverRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Handled Exception Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| exception              | System.Exception        | Required   |

```
TrackHandledExceptionRequest.Builder()
    .SetException(exception)
    .Create(
    trackHandledExceptionRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackHandledExceptionRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Http Failure Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| url                    | String                  | Required   |
| statusCode             | String                  | Required   |
| message                | String                  | Optional   |
| networkSpeed           | String                  | Required   |

```
TrackHttpFailureRequest.Builder()
    .Url(url)
    .StatusCode(statusCode)
    .Message(message)
    .NetworkSpeed(networkSpeed)
    .Create(
    trackHttpFailureRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackHttpFailureRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Http Success Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| url                    | String                  | Required   |
| statusCode             | String                  | Required   |
| message                | String                  | Optional   |
| networkSpeed           | String                  | Optional   |

```
TrackHttpSuccessRequest.Builder()
    .Url(url)
    .StatusCode(statusCode)
    .Message(message)
    .NetworkSpeed(networkSpeed)
    .Create(
    trackHttpSuccessRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackHttpSuccessRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Level End Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| level                  | Long                    | Required   |
| subLevel               | Long                    | Optional   |
| levelName              | String                  | Optional   |
| description            | String                  | Optional   |
| completeDuration       | String                  | Optional   |
| success                | String                  | Optional   |

```
TrackLevelEndRequest.Builder()
    .Level(level)
    .SubLevel(subLevel)
    .LevelName(levelName)
    .Description(description)
    .CompleteDuration(completeDuration)
    .Success(success)
    .Create(
    trackLevelEndRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackLevelEndRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Level Start Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| level                  | Long                    | Required   |
| subLevel               | Long                    | Optional   |
| levelName              | String                  | Optional   |
| description            | String                  | Optional   |

```
TrackLevelStartRequest.Builder()
    .Level(level)
    .SubLevel(subLevel)
    .LevelName(levelName)
    .Description(description)
    .Create(
    trackLevelStartRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackLevelStartRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Level Up Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| level                  | Long                    | Required   |
| subLevel               | Long                    | Optional   |
| levelName              | String                  | Optional   |
| character              | String                  | Optional   |
| description            | String                  | Optional   |

```
TrackLevelUpRequest.Builder()
    .Level(level)
    .SubLevel(subLevel)
    .LevelName(levelName)
    .Character(character)
    .Description(description)
    .Create(
    trackLevelUpRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackLevelUpRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Post Score Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| score                  | Long                    | Required   |
| level                  | Long                    | Optional   |
| subLevel               | Long                    | Optional   |
| levelName              | String                  | Optional   |
| character              | String                  | Optional   |

```
TrackPostScoreRequest.Builder()
    .Score(score)
    .Level(level)
    .SubLevel(subLevel)
    .LevelName(levelName)
    .Character(character)
    .Create(
    trackPostScoreRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackPostScoreRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Share Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| method                 | String                  | Required   |
| contentType            | String                  | Required   |

```
TrackShareRequest.Builder()
    .Method(method)
    .ContentType(contentType)
    .Create(
    trackShareRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackShareRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Sign-in Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| method                 | String                  | Required   |

```
TrackSigninRequest.Builder()
    .Method(method)
    .Create(
    trackSigninRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackSigninRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Sign-up Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| method                 | String                  | Required   |

```
TrackSignupRequest.Builder()
    .Method(method)
    .Create(
    trackSignupRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackSignupRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Start Timer Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| eventKey               | String                  | Required   |

```
TrackStartTimerRequest.Builder()
    .Event(eventKey)
    .Create(
    trackStartTimerRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackStartTimerRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Stop Timer Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| eventKey               | String                  | Required   |

```
TrackStopTimerRequest.Builder()
    .Event(eventKey)
    .Create(
    trackStopTimerRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackStopTimerRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Tutorial Begin Request Object

```
TrackTutorialBeginRequest.Builder()
    .Create(
    trackTutorialBeginRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackTutorialBeginRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Tutorial Complete Request Object

```
TrackTutorialCompleteRequest.Builder()
    .Create(
    trackTutorialCompleteRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackTutorialCompleteRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Unlock Achievement Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| achievementId          | String                  | Required   |
| achievementName        | String                  | Optional   |

```
TrackUnlockAchievementRequest.Builder()
    .AchievementId(achievementId)
    .AchievementName(achievementName)
    .Create(
    trackUnlockAchievementRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackUnlockAchievementRequest),
    onFailure =>
    {
        // handle failure
    });
```

##### Track Screen Time Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| screenName             | String                  | Required   |
| screenClass            | String                  | Required   |
| screenTime             | String                  | Required   |

```
TrackScreenTimeRequest.Builder()
        .ScreenName(screenName)
        .ScreenClass(screenClass)
        .TimeSpentOnScreen(screenTime)
        .Create(
            trackScreenTimeRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackScreenTimeRequest, response =>
            { 
                // handle success
            }),
            onFailure =>
            {
                // handle failure
            });
```



##### Track Purchase Request Object

| Parameter               | Type                                         | Field      |
| ----------------------  | -------------------------------------------- | ---------- |
| skuName                 | String                                       | Required   |
| skuDescription          | String                                       | Optional   |
| primaryPurchaseCategory | PurchaseCategory                             | Required   |
| purchaseType            | PurchaseType                                 | Required   |
| purchaseCurrencyType    | PurchaseCurrencyType                         | Required   |
| purchasePrice           | float                                        | Required   |
| percentDiscount         | int                                          | Optional   |
| amountRewarded          | int                                          | Optional   |
| skuName                 | String                                       | Optional   |
| skuDescription          | String                                       | Optional   |
| skuType                 | String                                       | Required   |
| skuSubType              | String                                       | Required   |
| purchaseDetails         | List<TrackPurchaseRequest.PurchaseInfo>      | Required   |
| timestamp               | String                                       | Required   |

```
PurchaseCategory primaryPurchaseCategory = PurchaseCategory.Currency.GOLD;
List<TrackPurchaseRequest.PurchaseInfo> purchaseDetails = new List<TrackPurchaseRequest.PurchaseInfo>();
PurchaseCategory secondayPurchaseCategory = PurchaseCategory.Currency.GOLD;
       TrackPurchaseRequest.PurchaseInfo data = TrackPurchaseRequest.PurchaseInfo.Builder()
        .SkuName(skuName)
        .SkuDescription(skuDescription)
        .PurchaseCategory(secondayPurchaseCategory)
        .Create();
        purchaseDetails.Add(data);
        
        TrackPurchaseRequest.Builder()
        .SkuName(skuName)
        .SkuDescription(skuDescription)
        .PurchaseCategory(primaryPurchaseCategory)
        .PurchaseType(purchaseType)
        .PurchaseCurrencyType(purchaseCurrencyType)
        .PurchasePrice(purchasePrice)
        .PercentDiscount(percentDiscount)
        .AmountRewarded(amountRewarded)
        .PurchaseDetails(purchaseDetails)
        .Create(
        trackPurchaseRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackPurchaseRequest),
        onFailure =>
        {
            Debug.Log("Unrecognized Error Occured");
        });

```

<a name="mikros-analytics-custom"></a>
#### Custom Analytics Events
Custom events can be tracked by the following ways:
#####  1. To log an event without any parameters
```
MikrosManager.Instance.AnalyticsController.LogEvent("custom_event_name", (Hashtable customEventWholeData) =>
{
    // handle success
},
onFailure =>
{
    // handle failure
});
```

##### 2. To log an event with only one parameter of String datatype
```
MikrosManager.Instance.AnalyticsController.LogEvent("custom_event_name", "parameter", "parameter_value", (Hashtable customEventWholeData) =>
{
    // handle success
},
onFailure =>
{
    // handle failure
});
```

##### 3. To log an event with only one parameter of Double datatype
```
MikrosManager.Instance.AnalyticsController.LogEvent("custom_event_name", "parameter", 1.5, (Hashtable customEventWholeData) =>
{
    // handle success
},
onFailure =>
{
    // handle failure
});
```

##### 4. To log an event with only one parameter of Long datatype
```
MikrosManager.Instance.AnalyticsController.LogEvent("custom_event_name", "parameter", 1, (Hashtable customEventWholeData) =>
{
    // handle success
},
onFailure =>
{
    // handle failure
});
```

##### 5. To log an event with multiple parameters of any datatype
```
Hashtable parameterData = new Hashtable();
parameterData.Add("parameter1", "parameter_value");
parameterData.Add("parameter2", 1.5);
parameterData.Add("parameter3", 1);
parameterData.Add("parameter4", true);
MikrosManager.Instance.AnalyticsController.LogEvent("custom_event_name", parameterData, (Hashtable customEventWholeData) =>
{
    // handle success
},
onFailure =>
{
    // handle failure
});
```

All custom events are uploaded automatically to backend at a feasible time whenever the phone is idle. However, these events can also be uploaded any time in the following way:
```
MikrosManager.Instance.AnalyticsController.FlushEvents();
```
<a name="mikros-authentication"></a>
## Mikros Authentication
To make any request you must first create a request object. This object uses a builder pattern, which is a design pattern designed to provide a flexible solution to various object creation problems. The intent of the Builder design pattern is to separate the construction of a complex object from its representation.
Make sure to have the following namespaces defined at the top of your scripts:
```
using MikrosClient;
using MikrosClient.Authentication;
```

### Sign-in
Sign-in request is used to authenticate and create a user session. By using this endpoint you will be adding users to the Mikros Ecosystem.

##### Request

| Parameter      | Type                    | Field                                                          |
| -------------- | ----------------------- | -------------------------------------------------------------- |
| username       | String                  | Required (if email is not provided, else pass empty string)    |
| email          | String                  | Required (if username is not provided, else pass empty string) |
| password       | String                  | Required                                                       |

Example of creating `SigninRequest`:

```
SigninRequest.Builder()
        .Username(username)
        .Email(email)
        .Password(password)
        .Create(signinRequest =>
        {
            MikrosManager.Instance.AuthenticationController.Signin(signinRequest, delegate (MikrosUser mikrosUser)
            {
                // signed in successfully.
            },
            delegate (MikrosException mikrosException)
            {
                // handle authentication error
            });
        },
        onFailure =>
        {
            // handle failure
        });
```

### Sign-up
Sign-up request is used to create a user in the database and consequently authenticate and create a user session. By using this endpoint you will be adding users to the Mikros Ecosystem.
*(Note: There's no need to call Sign-in function after successful Sign-up)*

##### Request

| Parameter                        | Type                    | Field    |
| ---------------------------------| ----------------------- | ---------|
| username                         | String                  | Required |
| email                            | String                  | Required |
| password                         | String                  | Required |
| enableUsernameSpecialCharacters  | String                  | Optional |

Example of creating `SignupRequest`:
```
SignupRequest.Builder()
        .Username(username)
        .Email(email)
        .Password(password)
        .EnableUsernameSpecialCharacters(enableUsernameSpecialCharacters)
        .Create(signupRequest =>
        {
            MikrosManager.Instance.AuthenticationController.Signup(signupRequest, delegate (MikrosUser mikrosUser)
            {
                // signed up successfully.
            },
            delegate (MikrosException mikrosException)
            {
                // handle authentication error
            });
        },
        onFailure =>
        {
            // handle failure
        });
```

*Note: From MikrosUser object the following details can be obtain.*
*   id
*   email
*   username
*   spendingScore
*   activityScore
*   reputationScore
*   created
*   updated      

### Signout
Calling sign-out will end the user session. You will receive a status code 200 if successful.

##### Request

Example of creating `SignoutRequest`:

```
MikrosManager.Instance.AuthenticationController.Signout(() =>
{
    // signed out successfully.
},
delegate (MikrosException mikrosException)
{
    // handle error
});
```

<a name="mikros-sso"></a>
## Mikros SSO
Mikros provides a built-in interactive UI to handle all authentication purposes.

Example of launching Mikros SSO:

| Parameter                | Type                    | Field                           |
| ------------------------ | ----------------------- | ------------------------------- |
| onAuthSuccess            | Action<MikrosUser>      | Optional                        |

```
MikrosManager.Instance.AuthenticationController.LaunchSignin(onAuthSuccess);

/// <summary>
/// Callback for handling auth success from Mikros SSO.
/// </summary>
/// <param name="mikrosUser">Mikros user instance.</param>
private void OnAuthSuccess(MikrosUser mikrosUser)
{
    Debug.Log("Auth Success: " + mikrosUser.Email);
}
```
The provided optional callback is executed if a signing or signup is performed successfully and returns an instance of the logged in Mikros user.

<a name="reputation-scoring"></a>
## Reputation Scoring
Mikros forms a Reputation profile for every users with the help of ratings provided by other users.
Make sure to have the following namespaces defined at the top of your scripts:
```
using MikrosClient;
using MikrosClient.GameService;
```

### Player Rating Request

| Parameter                | Type                    | Field                           |
| ------------------------ | ----------------------- | ------------------------------- |
| appGameId                | String                  | Required (Provided internally)  |
| apiKeyType               | String                  | Required (Provided internally)  |
| sender                   | Sender                  | Required                        |
| participants             | List<Participant>       | Required                        |

### Sender Request
*(Provided internally)

| Parameter                | Type                    | Field                           |
| ------------------------ | ----------------------- | ------------------------------- |
| senderDistinctId         | String                  | Required                        |

### Participant Request

| Parameter                | Type                    | Field                                        |
| ------------------------ | ----------------------- | -------------------------------------------- |
| participantDeviceId      | String                  | Required                                     |
| email                    | String                  | Optional                                     |
| playerBehavior           | PlayerBehavior          | Required                                     |
| value                    | Integer                 | Required (Generated w.r.t `playerBehavior`)  |
| behavior                 | String                  | Required (Generated w.r.t `playerBehavior`)  |

Example of creating `PlayerRating` request using list of `Participant` data:
```
List<Participant> participants = new List<Participant>();

Participant.Builder()
    .DistinctId(participantDistinctId1)
    .Email(email1)
    .Behavior(PlayerBehavior.CHEATING)
    .Create(
    participantRequest =>
    {
        participants.Add(participantRequest);
    },
    onFailure =>
    {
        // handle failure
    });
    
Participant.Builder()
    .DistinctId(participantDistinctId2)
    .Behavior(PlayerBehavior.GREAT_LEADERSHIP)
    .Create(
    participantRequest =>
    {
        participants.Add(participantRequest);
    },
    onFailure =>
    {
        // handle failure
    });

PlayerRating.Builder()
    .Participants(participants)
    .Create(
    playerRatingRequest =>
    {
        MikrosManager.Instance.GameServiceController.SendPlayerRating(playerRatingRequest, response =>
        {
            STATUS_TYPE statusType = Utils.DetectStatusType(response.Status.StatusCode);
            if(statusType == STATUS_TYPE.SUCCESS)
            {
                // Player Rating submitted successfully
            }
            else if(statusType == STATUS_TYPE.ERROR)
            {
                // Error occured during player rating submission
            }
            else
            {
                // other StatusCode that is related to other types of errors.
            }
        });
    },
    onFailure =>
    {
        // handle failure
    });
```

<a name="mikros-button"></a>
## Mikros Button
Mikros Button is the gateway to the Mikros App Store. This button can be placed on the game UI by the integrators. It can be found at:
```
GameObject (or right-click on Hierarchy window) -> UI -> Button - Mikros
```
Alternatively Mikros Button can also be created by clicking on `Add Component` from Inspector window of a gameObject and then choose `Mikros Button` option.

Mikros Button provides 2 options for its placement style on 2D UI, which are as follows:
1. STATIC
This is the default placement style selection. While choosing this option, integrators has the freedom to place the Mikros Button anywhere in their game UI according to their own layout.

2. FLOATING
This makes the Mikros Button acts as an overlay on the game UI and can be dragged by the user. The integrator won't have to place the Mikros Button fixed at any point in UI. Instead it will always cling to the side of the screen when idle.
Integrators also have the option to customize the floating behavior.

*NOTE: Mikros Button needs to be placed at the home screen UI of game to fulfil the basic requirement standards for making the app eligible to be listed on the Mikros Panel, which can be viewed by everyone in the Mikros ecosystem.* 
