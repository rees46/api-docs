# Promo codes

Service provides endpoint for unique promo codes fetching.

Note: unique promo codes are limited. Store fetched promo code during user's session.

## Fetch promo code

```shell
curl -d "ssid=SSID&shop_id=SHOPID&list_id=ID" https://api.rees46.com/promocodes/fetch?ssid=SSID&shop_id=SHOPID&list_id=ID
```

```javascript
r46("get_promo_code", 'PromoCodeListID', success_callback, error_callback);
```

> The above command returns JSON structured like this:

```json
{"code":  "UNIQUE_ID"}
```

### HTTP Request

`GET https://api.rees46.com/promocodes/fetch`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
ssid | true | Session ID of the user. You get it from `init` method in SDK.
shop_id | true | Your API key
seance | true | Temporary user session ID
list_id | true | Promo codes list ID

### Errors

When promo codes list is empty, method returns 404 error.