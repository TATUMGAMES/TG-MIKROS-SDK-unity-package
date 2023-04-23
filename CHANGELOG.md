# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<a name="released-versions"></a>
## Released Versions

* [1.3.0](#1.3.0)
* [1.2.1](#1.2.1)
* [1.2.0](#1.2.0)
* [1.1.0](#1.1.0) - Deprecated
* [1.0.0](#1.0.0) - Deprecated

## [Upcoming]

### MIKROS App Store 

- (IN PROGRESS) Working on creating solutions to bring exposure to the products using MIKROS. Our 
  primary goal is to ensure that products that use MIKROS are successful. This means that we not only 
  aim to help developers better understand their users via MIKROS Analytics, but we also want to drive 
  traffic towards these products as well via MIKROS Advertising (future feature).
 
  This is why we are working on a MIKROS App Store, which will allow developers the opportunity to
  market each others' products within the MIKROS ecosystem. More details to come as we build out the 
  necessary infrastructure and marketing machine.
  
<a name="1.3.0"></a>
## [1.3.0] - 2023-04-21

### Platform Compatibility

- Compatibile for both iOS and Android platforms.

### Enhancements

- Bug Fixes: Squashed some pesky bugs :bug:
- Gameplay Tracking: Added gameplay tracking as part of user metadata.
  
  Note: Developers still have full control over the type of user metadata data automatically collected. Remember that
  the data captured by MIKROS is completely configuratable by using [Privacy Levels](https://developer.tatumgames.com/documentation/disable-mikros-analytics).

### Dashboard

- Asset Update: Assets have been updated to give MIKROS a fresh new look! Let us know how you like them.
- New Global Analytics section, `Trends`. Trends allows developers to always know the latest trends across the entire mobile game industry. For the first time ever, developers can know in real-time valuable information such as what game genre is most popular, what content is least popular, how much are gamers spending and much more. 
- New Global Analytics section, `Statistics`. Statistics allows developers to monitor the growth of the MIKROS ecosystem.  

[Jump to Top](#released-versions)
  
<a name="1.2.1"></a>
## [1.2.1] - 2023-04-21

### Platform Compatibility

- Compatibile for both iOS and Android platforms.

### Enhancements

- Bug Fixes: Squashed some pesky bugs :bug:
- Device Memory: Added device memory tracking as part of user metadata.
  
  Note: Developers still have full control over the type of user metadata data automatically collected. Remember that
  the data captured by MIKROS is completely configuratable by using [Privacy Levels](https://developer.tatumgames.com/documentation/disable-mikros-analytics).

### Dashboard

- New Insights section, `Which Users Are the BIG Spenders?`. This section only populates with data if 
  you use the TrackPurchaseRequest() interface. You can learn more via the [technical documentation](https://developer.tatumgames.com/documentation/log-preset-events#track-purchase).
  
[Jump to Top](#released-versions)  

<a name="1.2.0"></a>
## [1.2.0] - 2022-10-07

### Platform Compatibility

- Compatibile for both iOS and Android platforms.

### Added Interfaces

- TrackPurchaseRequest(): Use this as receipt tracking for all purchases made. By calling this 
  interface you will be able to see a more in-depth financial breakdown of your earnings. And you 
  will be able to see itemized user details about their spending interests and spending habits.

  Note: Remember that MIKROS is an ecosystem. The more developers that participate and contribute to 
  the ecosystem, the more powerful MIKROS becomes. If you want to see how users are spending inside 
  and outside of your product, all developers need to use MIKROS to help complete the users' entire 
  finanicial journey.

### Dashboard

- New Insights section, `Which Users Are the BIG Spenders?`. This section only populates with data if 
  you use the TrackPurchaseRequest() interface. You can learn more via the [technical documentation](https://developer.tatumgames.com/documentation/log-preset-events#track-purchase). 

[Jump to Top](#released-versions)

<a name="1.1.0"></a>
## [1.1.0] - 2021-12-17 (Version no longer supported)

### Platform Compatibility

- Compatibile for both iOS and Android platforms.

### Added Interfaces

- TrackHandledExceptionRequest(): Use this to log any handled exceptions. This should be added to 
  try-catch exceptions and to failed API cases to get a better understanding of how gracefully you are 
  handling non-ideal scenarios.
- TrackHttpFailureRequest(): Use this to track when HTTP requests fail. In combination with tracking 
  the success of HTTP requests, you will begin to understand how healthy your request stack and backend is.
- TrackHttpSuccessRequest(): Use this to track when HTTP requests succeed.  
  
  Note: Any ANRs and crashes will be logged automatically. You are now able to see these issues on your 
  dashboard.
  
### Dashboard

- New Insights section, `Things Your Business Should Know`. This section populates automatically. You can 
  learn more via the [technical documentation](https://developer.tatumgames.com/documentation/preset/business). 

[Jump to Top](#released-versions)

<a name="1.0.0"></a>
## [1.0.0] - 2021-05-11 (Version no longer supported)

### Added

- This CHANGELOG file to hopefully serve as an evolving example of the type of transparency Tatum Games 
  wants to have with MIKROS Integrators.
- README now contains more information about MIKROS as well as answers to common questions. For additional 
  information, you can learn more via the [FAQ](https://stage-developer.tatumgames.com/documentation/faq)

### Added Interfaces

- LogEvent(): Used to log any custom event. The events you track will be visible in real-time on
  the MIKROS dashboard.
- SigninRequest(): This is a SSO (Single Sign-On) feature. By using authentication through MIKROS, 
  you allow users to convienantly sign into your app. Additionally, this helps us track user behaviors 
  across all apps where MIKROS SSO is used.
- SignupRequest(): This is a SSO (Single Sign-On) feature. By using registration through MIKROS, you set 
  users up to be able to sign into any app where MIKROS SSO is used.
- SignoutRequest(): This will log the user out of MIKROS SSO (Single Sign-On).
- PlayerRating(): Used to allow players to rate each other after a match, battle or challenge. This rating
  directly affects user [Reputation Score](https://developer.tatumgames.com/documentation/scores#reputation-score).

### Convenience Interfaces

The following interfaces are convenience interfaces for Integrators. These out-of-box interfaces 
call `LogEvent()` internally and will track the provided information and details.

- TrackGameOverRequest(): Use this to track when a user faces game over or level failure.
- TrackHandledExceptionRequest(): Use this to log any handled exceptions.
- TrackHttpFailureRequest(): Use this to track when HTTP requests fail.
- TrackHttpSuccessRequest(): Use this to track when HTTP requests succeed.
- TrackLevelStartRequest(): Use this to track when a user starts a level.
- TrackLevelEndRequest(): Use this to track when a user has successfully completed a level. This should be used in 
  conjunction with `TrackLevelStartRequest()`.
- TrackLevelUpRequest(): Use this when a user levels up. You can include level and character
  details e.g. type of character, character name, or username.
- TrackPostScoreRequest(): Use this to track any changes in score. You can include level and character
  details e.g. type of character, character name, or username.
- TrackShareRequest(): Use this to track when a user shares something via social media.
- TrackSigninRequest(): Use this to track when a user authenticates. Integrators don't have to use
  this with MIKROS SSO authentication. They can call this when a user authenticates through
  their own authentication system as well.
- TrackSignupRequest(): Use this to track when a user registers an account. Integrators don't have
  to use this with MIKROS SSO registration. They can call this when a user registers through
  their own authentication system as well.
- TrackStartTimerRequest(): Use this to start tracking any timed events.
- TrackStopTimerRequest(): Use this to stop tracking any timed events. This should be used in conjunction
  with `TrackStartTimerRequest()`.
- TrackTutorialBeginRequest(): Use this to track when users start a tutorial.
- TrackTutorialCompleteRequest(): Use this to track when users have completed a tutorial. This should be used in
  conjunction with `TrackTutorialBeginRequest()`.
- TrackUnlockAchievementRequest(): Use this to track any unlock achievements e.g. level unlock, item
  unlock, or feature unlock.
- TrackScreenTimeRequest(): Use this to track how long users are spending on a specific screen.
- TrackPurchaseRequest(): Use this as receipt tracking for all purchases made.  

[Jump to Top](#released-versions)
