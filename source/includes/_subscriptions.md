# Subscriptions

Service provides methods to manage user's subscriptions

## Manage subscriptions

### HTTP Request

`POST https://api.rees46.com/subscriptions/manage`

### Subscribe user to mailings

```shell
curl -d "shop_id=SHOPID&shop_secret=SECRET&email=my@email.com&event=subscribed&segment_id=SEGMENT_ID" \
https://api.rees46.com/subscriptions/manage
```

> The above command returns JSON structured like this:

```json
{'status':  'success'}
```

Parameter | Required | Description
--------- | ------- | -----------
shop_id | true | Your API key
shop_secret | true | Secret API key
email | true | User's email
event | true | Event to process: `subscribed`
segment_id | false | Segment ID to put subscribed user (only for `subscribed` event).


### Unsubscribe user from mailings

Use this method to unsubscribe user from all types of mailings:

```shell
curl -d "shop_id=SHOPID&shop_secret=SECRET&email=my@email.com&&event=unsubscribed" \
https://api.rees46.com/subscriptions/manage
```

> The above command returns JSON structured like this:

```json
{'status':  'success'}
```

Parameter | Required | Description
--------- | ------- | -----------
shop_id | true | Your API key
shop_secret | true | Secret API key
email | true | User's email
event | true | Event to process: `unsubscribed`


### Email is bounced

Use this method only for hard bounces. Don't use it for soft bounce, because it purges email from database forever.

```shell
curl -d "shop_id=SHOPID&shop_secret=SECRET&email=my@email.com&event=bounced" \
https://api.rees46.com/subscriptions/manage
```

> The above command returns JSON structured like this:

```json
{'status':  'success'}
```

Parameter | Required | Description
--------- | ------- | -----------
shop_id | true | Your API key
shop_secret | true | Secret API key
email | true | User's email
event | true | Event to process: `bounced`

### Email is complained

Use this method on FBL request (user marked email as spam):

```shell
curl -d "shop_id=SHOPID&shop_secret=SECRET&email=my@email.com&event=complained" \
https://api.rees46.com/subscriptions/manage
```

> The above command returns JSON structured like this:

```json
{'status':  'success'}
```

Parameter | Required | Description
--------- | ------- | -----------
shop_id | true | Your API key
shop_secret | true | Secret API key
email | true | User's email
event | true | Event to process: `complained`
