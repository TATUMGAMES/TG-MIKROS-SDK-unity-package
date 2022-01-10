## Table of Contents

* [What is MIKROS?](#what-is-mikros)
* [How Does MIKROS Work?](#how-dose-mikros-work)
* [How to Implement MIKROS?](#how-to-implement-mikros)
* [What is MIKROS Community Slack?](*what-is-mirkos-community-slack)
* [How to Join MIKROS Community Slack?](*how-to-join-mikros-community-slack)
* [What Are the Rules For The MIKROS Community Slack?](*what-are-the-rules-for-the-mikros-community-slack)
* [FAQ](*faq)


<a name="what-is-mikros"></a>
## What Is MIKROS?
MIKROS is a service aimed at game developers which provides useful information and clear analytics in a sharing ecosystem, also known as data pooling. These insights about user behaviour can help developers understand their clientele better including their spending habits. MIKROS uniquely displays its analytics in a simple format with the goal of connecting game developers and advertisers to a full understanding of the problems they are looking to solve. This is due to all the data being in the MIKROS ecosystem.

<a name="how-dose-mirkos-work"></a>
## How Does MIKROS Work?
MIKROS sorts users by spending and activity levels in its ecosystem. This differs from how data is currently managed by competitors as they do not offer any data pooling. Game developers and advertisers can then view reports in a dashboard with valuable information which is needed to identify areas to improve their customer experience. With MIKROS, advertisers can now be certain that their ads are being shown to verified spenders.

<a name="how-to-implement-mirkos"></a>
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

<a name="what-is-mikros-community-slack"></a>
## What is MIKROS Community Slack?

<a name="how-to-join-mikros-community-slack"></a>
## How to Join MIKROS Community Slack?

<a name="what-are-the-rules-for-the-mikros-community-slack"></a>
## What Are the Rules For the MIKROS Community Slack?

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
