# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Released Versions

* [1.1.0](#1.1.0)
* [1.0.0](#1.0.0)

## [Upcoming]

### Track User Spending 

- (IN PROGRESS) Working on preset event interfaces for tracking user spending. By 
  using these interfaces Integrators of MIKROS will be able to see information regarding 
  user spending habits e.g. how much and frequency of spending via Spending Score.
  
<a name="1.1.0"></a>
## [1.1.0] - 2021-12-17

### Platform Compatibility

- Compatibile for both iOS and Android platforms.

### Added Interfaces

- TrackHandledExceptionRequest(): Use this to log any handled exceptions. This should be added to try-catch exceptions 
  and to failed API cases to get a better understanding of how gracefully you are handling non-ideal scenarios.

<a name="1.0.0"></a>
## [1.0.0] - 2021-05-11

### Added

- This CHANGELOG file to hopefully serve as an evolving example of the type
  of transparency Tatum Games wants to have with MIKROS Integrators.
- README now contains more information about MIKROS as well as answers to common questions.

### Added Interfaces

- LogEvent(): Used to log any custom event. The events you track will be visible in real-time
  on the MIKROS dashboard.
- SigninRequest(): This is a SSO (Single Sign-On) feature. By using authentication through 
  MIKROS, you allow users to convienantly sign into your app. Additionally, this helps us
  track user behaviors across all apps where MIKROS SSO is used.
- SignupRequest(): This is a SSO (Single Sign-On) feature. By using registration through 
  MIKROS, you set users up to be able to sign into any app where MIKROS SSO is used.
- SignoutRequest(): This will log the user out of MIKROS SSO (Single Sign-On).
- PlayerRating(): Used to allow players to rate each other after a match, battle or challenge.
  This rating directly affects user [Reputation Score](https://developer.tatumgames.com/documentation/scores#reputation-score).

### Convenience Interfaces

The following interfaces are convenience interfaces for Integrators. These out-of-box interfaces 
call LogEvent() and will track the provided information and details.

- TrackGameOverRequest(): Use this to track when a user faces game over or level failure.
- TrackLevelStartRequest(): Use this to track when a user starts a level.
- TrackLevelEndRequest(): Use this to track when a user has successfully completed a level. This should be used in 
  conjunction with `TrackLevelStartRequest()`.
- TrackLevelUpRequest(): Use this when a user levels up. You can include level and character
  details e.g. type of character, character name, or username.
- TrackPostScoreRequest(): Use this to track any changes in score. You can include level and character
  details e.g. type of character, character name, or username.
- TrackShareRequest(): Use this to track when a user does a share function.
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
