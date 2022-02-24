## Table of Contents

* [What is MIKROS?](#what-is-mikros)
* [How Does MIKROS Work?](#how-does-mikros-work)
* [How to Implement MIKROS?](#how-to-implement-mikros)
* [Sample App & Documentation](#sample-app-&-documentation)
	* [Authentication](#authentication)
	* [SDK Initialization](#sdk-initialization)
	* [Privacy Standard](#privacy-standard)
	* [Mikros Analytics](#mikros-analytics)
		* [Preset Analytics Events](#mikros-analytics-preset)
		* [Custom Analytics Events](#mikros-analytics-custom)
* [What is MIKROS Community Slack?](*what-is-mirkos-community-slack)
* [How to Join MIKROS Community Slack?](*how-to-join-mikros-community-slack)
* [What Are the Rules For The MIKROS Community Slack?](*what-are-the-rules-for-the-mikros-community-slack)
* [FAQ](*faq)



<a name="what-is-mikros"></a>
## What Is MIKROS?
MIKROS is a service aimed at game developers which provides useful information and clear analytics in a sharing ecosystem, also known as data pooling. These insights about user behaviour can help developers understand their clientele better including their spending habits. MIKROS uniquely displays its analytics in a simple format with the goal of connecting game developers and advertisers to a full understanding of the problems they are looking to solve. This is due to all the data being in the MIKROS ecosystem.

<a name="how-does-mikros-work"></a>
## How Does MIKROS Work?
MIKROS sorts users by spending and activity levels in its ecosystem. This differs from how data is currently managed by competitors as they do not offer any data pooling. Game developers and advertisers can then view reports in a dashboard with valuable information which is needed to identify areas to improve their customer experience. With MIKROS, advertisers can now be certain that their ads are being shown to verified spenders.

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

<a name="sample-app-&-documentation"></a>
## Sample App & Documentation

<a name="authentication"></a>
### Authentication
    
    
This is the Mikros Sample App main screen. The Authentication button will allow you to be authenticated and allow you to use the Mikros Sample App.

![MIKROS MAIN SCREEN, add from Git URL dropdown](Documentation/Mikros-main-screen.png)

After clicking the Authentication button you will be presented with 3 options. (Sign-in, Sign-up, and Sign-out)

![MIKROS SIGN-IN OPTIONS, add from Git URL dropdown](Documentation/Mikros-sign-in.png) 

After clicking the Sign-up button you will  be presented with this screen and will need a Username, Email, and Password to sign up.

![MIKROS SIGN-UP , add from Git URL dropdown](Documentation/sign-up.png) 

After clicking the Sign-out button you will be presented with this message. Letting you know you have signed out of the Mikros Sample App.

![MIKROS SIGN-OUT , add from Git URL dropdown](Documentation/sign-out.png) 

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

##### Initialize with custom Privacy Level

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| privacyLevel           | PRIVACY_LEVEL           | Optional   |
| isEventLogging         | Boolean                 | Required   |

```
Configuration configuration = Configuration.Builder().SetPrivacyLevel(privacyLevel).SetEventLogging(isEventLogging).Create();
MikrosManager.Instance.InitializeMikrosSDK(configuration);
```

*Note: The privacy configuration that is set in MikrosSettings from Editor, will always get overriden whenever a Configuration parameter is passed to the `MikrosManager.Instance.InitializeMikrosSDK` method.*


You can use the `MikrosManager.Instance` and request objects to perform any operation. You will also need to pass in the correct response callbacks.

<a name="privacy-standard"></a>
* Privacy Standard
Mikros provides 3 levels of privacy, all of which are GDPR & CCPA compliant. Following is the description for each privacy level:
1. PRIVACY_LEVEL.DEFAULT
   (Recommended) Mikros tracks user metadata and session in the background.

2. PRIVACY_LEVEL.HIGH
   Mikros no longer tracks any metadata information in the background; only session is tracked.

3. PRIVACY_LEVEL.EXTREME
   Mikros no longer tracks any metadata or session in the background. Integrators will have to track manually.

However, Mikros also provides interfaces to set privacy standards according to requirement. This can be done as follows:

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| isTrackUserSession     | Boolean                 | Required   |
| isTrackUserMetadata    | Boolean                 | Required   |
| isEventLogging         | Boolean                 | Required   |

```
MikrosManager.Instance.ConfigurationController.SetAutoTrackUserSession(isTrackUserSession);
MikrosManager.Instance.ConfigurationController.SetAutoTrackUserMetadata(isTrackUserMetadata);
MikrosManager.Instance.ConfigurationController.SetEventLogging(isEventLogging);
```

If at any point it is required to customize logging of all type of user activity tracking (preset events, custom events, metadata, session), it can be done as follows:

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| isAllTrackingEnabled   | Boolean                 | Required   |
```
MikrosManager.Instance.ConfigurationController.SetAllTrackingEnabled(isDisableAllTracking);
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
#### Preset Analytics Events

##### Track App Open Request Object

```
TrackAppOpenRequest.Builder()
    .Create(
    trackAppOpenRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackAppOpenRequest),
    onFailure =>
    {
        // handle failure
    });
```

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

<a name="mikros-analytics-custom"></a>
#### Custom Analytics Events
Custom events can be tracked by the following ways:
1. To log an event without any parameters
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

2. To log an event with only one parameter of String datatype
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

3. To log an event with only one parameter of Double datatype
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

4. To log an event with only one parameter of Long datatype
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

5. To log an event with multiple parameters of any datatype
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

<a name="what-is-mikros-community-slack"></a>
## What is MIKROS Community Slack?
MIKROS Community Slack aims to have the largest number of communities and viewpoints as inclusivity is our primary goal. We are committed to providing a friendly, safe and welcoming environment for all, regardless of gender, sexual orientation, ability, ethnicity, socioeconomic status, age, and religion (or lack thereof).

<a name="how-to-join-mikros-community-slack"></a>
## How to Join MIKROS Community Slack?

<a name="what-are-the-rules-for-the-mikros-community-slack"></a>
## What Are the Rules For the MIKROS Community Slack?
The following behaviors are expected and requested of all community members:

* When you choose to participate, do so authentically and productively. In doing so, you contribute to the health and longevity of this community.
* Exercise consideration and respect in your speech and actions.
* Attempt collaboration before conflict.
* Be mindful of your surroundings and of your fellow participants. Alert community leaders if you notice a dangerous situation, someone in distress, or violations of this Code of Conduct, even if they seem inconsequential.

The following behaviors are considered unacceptable within our community:

* Violence, threats of violence or violent language directed against another person.
* Sexist, racist, homophobic, transphobic, ableist or otherwise discriminatory jokes and language.
* Demeaning language, personal and ad hominem attacks on other persons, whether they are a member of the MIKROS community or external to it.
* Posting or displaying sexually explicit or violent material.
* Posting or threatening to post other people’s personally identifying information ("doxing").
* Personal insults, particularly those related to gender, sexual orientation, race, religion, age, or disability.
* Publicly shaming.
* Unwelcome sexual attention. This includes, but is not limited to, sexualized comments or jokes.
* Deliberate intimidation, stalking or following (online or in person).
* Advocating for, or encouraging, any of the above behavior.

If someone is subject to or witnesses unacceptable behavior, or has any other concerns, they are strongly encouraged to notify an administrator as soon as possible. Every reported concern will follow this workflow until resolved:

* Make contact by emailing support@tatumgames.com
* Your email message will reach the MIKROS Slack core team.
* Reports will be confidential within the core team.

Alternative ways of reporting guidelines and more information can be found [here](https://developer.tatumgames.com/documentation/slack) on the MIKROS website.

<a name="faq"></a>
## FAQ 




# TG-MIKROS-SDK-unity-package
MIKROS is a SaaS product that enrolls developers in an information sharing ecosystem, also known as data pooling, that helps identify better insights about user behavior. Including user spending habits.

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


 
 
 
