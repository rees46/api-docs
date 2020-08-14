---
title: REES46 API Reference

language_tabs:
  - shell
  - javascript
  - swift

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - search
  - mobile_push_tokens
  - errors

search: true

code_clipboard: true
---

# Introduction

Welcome to REES46 API Reference. This reference will help you to create new, more effective S2S or M2S integration.

Our API is RESTful and you can use any language to work with it.

We provide examples as `shell` request and JS SDK usage. Later we will add Android SDK and iOS SDK examples.

# Authentication

To authorize, send all requests with `shop_id` parameter. You can send it both in POST and GET requests. 

This parameter identifies your shop.

```shell
curl "https://api.rees46.com/?shop_id=357382bf66ac0ce2f1722677c59511"
```

<aside class="notice">
You must replace <code>357382bf66ac0ce2f1722677c59511</code> with your shop's API key.
</aside>

# Initialize

## Start session

`GET https://api.rees46.com/init_script`

```shell
curl https://api.rees46.com/init_script?ssid=SSID&shop_id=SHOPID&v=3&seance=SEANCE_ID&referrer=REF_URL
```

```javascript
(function(r){window.r46=window.r46||function(){(r46.q=r46.q||[]).push(arguments)};var s=document.getElementsByTagName(r)[0],rs=document.createElement(r);rs.async=1;rs.src='//cdn.rees46.com/v3.js';s.parentNode.insertBefore(rs,s);})('script');
r46('init', 'SHOPID');
```

```swift
import REES46
var sdk = createPersonalizationSDK(shopId: "SHOPID")
```

Before using SDK or API you have to initialize SDK. Initialization takes current user identifier and requests API for project settings and this user preferences. 

If you don't have user's identifier (new user), you have to request API's `init` method to generate new one. Store this identifier (it's named `ssid`) in local storage of mobile application or in database: you'll need it for the future requests to API. 

<aside class="notice">
This method must be requested on every opened page on the website. And only once, when you launch mobile app.
</aside>


### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
shop_id | true | Your API key
ssid | false | Is mandatory if you have it. Request without `ssid` will generate new one in our DB. Use it as user ID for future requests.
v | true | Version. Just use `3` as value.
seance | true | User's temporary identifier for the current session. Must be regenerated every time user starts new session. Just unique string: `uuid8` is ok.
referrer | false | Referrer page URL for web integration.

