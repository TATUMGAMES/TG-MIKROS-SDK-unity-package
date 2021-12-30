1. Initialisation Processes

## Initialize Mikros without Configuration (using settings from Mikros Settings in the Unity Editor).
```
MikrosManager.Instance.InitializeMikrosSDK();
```

## Initialize Mikros with Configuration.
```
Configuration configuration = Configuration.Builder().SetPrivacyLevel(PRIVACY_LEVEL.EXTREME).SetEventLogging(true).Create();
MikrosManager.Instance.InitializeMikrosSDK(configuration);
```

*If "Auto Initialize Mikros SDK" option is enabled from Unity Editor via Mikros Settings, then manual initialisation of Mikros SDK via code won't work.*

2. Custom Data Tracking

## To change only session tracking settings (Optional).
```
MikrosManager.Instance.ConfigurationController.SetAutoTrackUserSession(true);
```

## To change only metadata tracking settings (Optional).
```
MikrosManager.Instance.ConfigurationController.SetAutoTrackUserMetadata(true);
```

## To change only event logging settings (Optional).
```
MikrosManager.Instance.ConfigurationController.SetEventLogging(true);
```

## To change all data tracking settings at once (Optional)
```
MikrosManager.Instance.ConfigurationController.SetAllTrackingEnabled(true);
```

## To view status of each configuration
```
bool isTrackMetadata = MikrosManager.Instance.ConfigurationController.IsTrackUserMetadata;
bool isTrackSession = MikrosManager.Instance.ConfigurationController.IsTrackUserSession;
bool isEventLogging = MikrosManager.Instance.ConfigurationController.IsEventLogging;
bool isAllTrackingEnabled = MikrosManager.Instance.ConfigurationController.IsAllTrackingEnabled;
```

3. Mikros Settings Data

## App Game ID that is set by integrator from Editor.
```
string appGameId = MikrosManager.Instance.ConfigurationController.MikrosSettings.AppGameID;
```

## Production API key that is set by integrator from Editor.
```
string apiKeyProduction = MikrosManager.Instance.ConfigurationController.MikrosSettings.ApiKeyProduction;
```

## Development API key that is set by integrator from Editor.
```
string apiKeyDevelopment = MikrosManager.Instance.ConfigurationController.MikrosSettings.ApiKeyDevelopment;
```

## QA API key that is set by integrator from Editor.
```
string apiKeyQA = MikrosManager.Instance.ConfigurationController.MikrosSettings.ApiKeyQA;
```

## Type of API key that is being used currently, which is set by integrator from Editor.
```
API_KEY_TYPE apiKeyType = MikrosManager.Instance.ConfigurationController.MikrosSettings.CurrentApiKeyType;
```

## API key which is being used currently, set by integrator from Editor.
```
string currentUsedApiKey = MikrosManager.Instance.ConfigurationController.MikrosSettings.GetCurrentApiKey();
```


4. Authentication

## Signup
```
SignupRequest.Builder()
	.Username("sampleUser")
	.Email("sampleUser@gmail.com")
	.Password("abcd1234")
	.Create(signupRequest =>
	{
		Debug.Log("All input correct!!!!");

		MikrosManager.Instance.AuthenticationController.Signup(signupRequest, successResponse =>
		{
			Debug.Log("Sign up success.");
		},
		failureResponse =>
		{
			Debug.Log(failureResponse.Message);
		});
	},
	onFailure =>
	{
		Debug.Log(onFailure.Message);
	});
```

## Signin
```
SigninRequest.Builder()
	.Username("sampleUser")
	.Email("sampleUser@gmail.com")
	.Password("abcd1234")
	.Create(signinRequest =>
	{
		MikrosManager.Instance.AuthenticationController.Signin(signinRequest, successResponse =>
		{
			Debug.Log("Sign in success.");
		},
		failureResponse =>
		{
			Debug.Log(failureResponse.Message);
		});
	},
	onFailure =>
	{
		Debug.Log(onFailure.Message);
	});
```

## Signout
```
MikrosManager.Instance.AuthenticationController.Signout(() =>
{
	Debug.Log("Sign out success.");
},
failureResponse =>
{
	Debug.Log(failureResponse.Message);
});
```

## Launch Mikros SSO
```
MikrosManager.Instance.AuthenticationController.LaunchSignin();
```

## Launch Mikros SSO with signed-in user callback
```
MikrosManager.Instance.AuthenticationController.LaunchSignin((MikrosUser mikrosUser) =>
{
	Debug.Log(mikrosUser.Email);
});
```

## Get object instance of signed-in Mikros user
```
MikrosUser mikrosUser = MikrosManager.Instance.AuthenticationController.MikrosUser;
```


5. Mikros App Store Events

## Subscribe to App Store open event
```
MikrosManager.Instance.AdController.StoreListener.OnOpened += AppStoreOpened;

private void AppStoreOpened()
{
	Debug.Log("App store opened");
}
```

## Subscribe to App Store close event
```
MikrosManager.Instance.AdController.StoreListener.OnClosed += AppStoreClosed;

private void AppStoreClosed()
{
	Debug.Log("App store closed");
}
```

## Subscribe to error events in App Store
```
MikrosManager.Instance.AdController.StoreListener.OnError += AppStoreError;

private void AppStoreError(MikrosException exception)
{
	Debug.Log("App store error\n" + exception.Message);
}
```


6. Custom Events

## Custom event without parameter.
```
MikrosManager.Instance.AnalyticsController.LogEvent("Event Name 1", (Hashtable customEvent) =>
{
	// a Hashtable of the custom event is returned after success.
},
onFailure =>
{
	Debug.Log(onFailure.Message);
});
```

## Custom event with string type parameter.
```
MikrosManager.Instance.AnalyticsController.LogEvent("Event Name 2", "test_key", "custom_test_value", (Hashtable customEvent) =>
{
	// a Hashtable of the custom event is returned after success.
},
onFailure =>
{
	Debug.Log(onFailure.Message);
});
```

## Custom event with long type parameter.
```
MikrosManager.Instance.AnalyticsController.LogEvent("Event Name 3", "test_key", 1, (Hashtable customEvent) =>
{
	// a Hashtable of the custom event is returned after success.
},
onFailure =>
{
	Debug.Log(onFailure.Message);
});
```

## Custom event with double type parameter.
```
MikrosManager.Instance.AnalyticsController.LogEvent("Event Name 4", "test_key", 3.67f, (Hashtable customEvent) =>
{
	// a Hashtable of the custom event is returned after success.
},
onFailure =>
{
	Debug.Log(onFailure.Message);
});
```

## Custom event with Hashtable type parameter.
```
Hashtable dataset = new Hashtable();
dataset.Add("key_1", "custom_test_value");
dataset.Add("key_2", 1);
dataset.Add("key_3", 3.67f);
MikrosManager.Instance.AnalyticsController.LogEvent("Event Name 5", dataset, (Hashtable customEvent) =>
{
	// a Hashtable of the custom event is returned after success.
},
onFailure =>
{
	Debug.Log(onFailure.Message);
});
```

## To test custom events in Editor
```
Hashtable dataset = new Hashtable();
dataset.Add("key_1", "custom_test_value");
dataset.Add("key_2", 1);
dataset.Add("key_3", 3.67f);
MikrosManager.Instance.AnalyticsController.TestCustomEvents(new List<Hashtable> { dataset }, response =>
{
	Debug.Log(response.Status.StatusMessage);
});
```


7. Preset Events

## Track Game Over Request Object

```
TrackGameOverRequest.Builder()
	.Create(
	trackGameOverRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackGameOverRequest),
	onFailure =>
	{
		// handle failure
	});
```

## Track Handled Exception Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| description            | String                  | Required   |
| exceptionType          | String                  | Required   |
| exceptionMessage       | String                  | Required   |
| isFatal                | Boolean                 | Optional   |

```
TrackHandledExceptionRequest.Builder()
	.Description(description)
	.ExceptionType(exceptionType)
	.ExceptionMessage(exceptionMessage)
	.ExceptionFatal(isFatal)
	.Create(
	trackHandledExceptionRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackHandledExceptionRequest),
	onFailure =>
	{
		// handle failure
	});
```

## Track Http Failure Request Object

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

## Track Http Success Request Object

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

## Track Level End Request Object

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

## Track Level Start Request Object

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

## Track Level Up Request Object

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

## Track Post Score Request Object

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

## Track Share Request Object

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

## Track Sign-in Request Object

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

## Track Sign-up Request Object

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

## Track Start Timer Request Object

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

## Track Stop Timer Request Object

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

## Track Tutorial Begin Request Object

```
TrackTutorialBeginRequest.Builder()
	.Create(
	trackTutorialBeginRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackTutorialBeginRequest),
	onFailure =>
	{
		// handle failure
	});
```

## Track Tutorial Complete Request Object

```
TrackTutorialCompleteRequest.Builder()
	.Create(
	trackTutorialCompleteRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackTutorialCompleteRequest),
	onFailure =>
	{
		// handle failure
	});
```

## Track Exception Request Object

| Parameter              | Type                    | Field      |
| ---------------------- | ----------------------- | ---------- |
| exception              | Exception               | Required   |
| ExceptionSubType       | EXCEPTION_SUB_TYPE(enum)| Required   |
```
TrackUnhandledExceptionRequest.Builder()
	.SetException(exception)
	.ExceptionSubType(exceptionType)
	.Create(
	trackUnhandledExceptionRequest => MikrosManager.Instance.AnalyticsController.LogEvent(trackUnhandledExceptionRequest),
	onFailure =>
	{
		// handle failure
	});
```

## Track Unlock Achievement Request Object

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


8. Player Rating

## Create `PlayerRating` request using `Sender` and `Participant` data
Example of creating `PlayerRating` request using `Sender` and `Participant` data:
```
Sender sender = Sender.Builder().Create();

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
	.Sender(sender)
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