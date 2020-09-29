# User's profile

Endpoints is used to work with user's profile.

## Save profile settings

This method overrides profile's settings.

```shell
curl -d "shop_id=SHOPID&shop_secret=SHOP_SECRET&email=EMAIL&fieldname=FIELDVALUE" https://api.rees46.com/profile/set
```
### Query Parameters

Parameter | Type | Required | Description
--------- | ------- | -------  | -----------
shop_id | String | true | Your API key
shop_secret | String | true | Your API secret key
email | String | true | User's email

