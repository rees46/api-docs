# Mobile push tokens

## Create new token

```shell
curl -d "did=DEVICE_ID&shop_id=SHOPID&token=TOKEN&platform=PLATFORM" https://api.rees46.com/mobile_push_tokens
```

> The above command returns JSON structured like this:

```json
{}
```

This endpoint creates new token for the user, identified by `did` parameter.

### HTTP Request

`POST https://api.rees46.com/mobile_push_tokens`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
did | true | Device ID. You get it from `init` method in SDK.
platform | true | Identifies platform: `ios` or `android`
token | true | Unique mobile push token from iOS or Android.
shop_id | true | Your API key

