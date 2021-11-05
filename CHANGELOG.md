# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Upcoming]

### Track User Spending 

- (IN PROGRESS) Working on preset event interfaces for tracking user spending. By 
  using these interfaces Integrators of MIKROS will be able to see information regarding 
  user spending habits e.g. how much and frequency of spending via Spending Score.

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
