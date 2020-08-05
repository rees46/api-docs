---
title: REES46 API Reference

language_tabs:
  - shell
  - javascript

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
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

# Mobile push tokens

## Create new token

```shell
curl -d "ssid=SSID&shop_id=SHOPID&token=TOKEN&platform=PLATFORM" https://api.rees46.com/mobile_push_tokens
```

> The above command returns JSON structured like this:

```json
{}
```

This endpoint creates new token for the user, identified by `ssid` parameter.

### HTTP Request

`POST https://api.rees46.com/mobile_push_tokens`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
ssid | true | Session ID of the user. You get it from `init` method in SDK.
platform | true | Identifies platform: `ios` or `android`
token | true | Unique mobile push token from iOS or Android.
shop_id | true | Your API key

