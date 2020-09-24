# URL shortener

This service provides functionality to make shortened URLs and generate QR codes for an URL.

## Create short URL

> Headers

```
Content-type: application/json
```

> Body example

```json 
{
    "shop_id": "...",
    "shop_secret": "...",
    "links": [
        {
            "url": "https://example.com/page/1/?utm_source=source...",
        },
        {
            "url": "https://example.com/page/2/?utm_source=source...",
            "lifetime": 60,
        },
        {
            "url": "https://example.com/page/3/?utm_source=source...",
            "code": "a",
            "lifetime": 10,
        }
    ]
}
```

> Request example

```shell
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"shop_id":"...","shop_secret":"...","links":[{"url":"https://example.com/page/1"},{"url":"https://example.com/page/1","code":"a"}]}' \
  https://api.rees46.com/url/create
```

> Response example:

```json
[
  {
    "source": "https://example.com/page/1",
    "url": "https://r46.dev/x27FyAlR"
  },
  {
    "source": "https://example.com/page/2",
    "url": "https://r46.dev/a"
  }
]
```

The endpoint allows to create 1 to N shortened URLs. Use batch request to shorten hundreds of URLs at once.

### HTTP Request

Method | Endpoint | Content-type
--------- | --------- | ---------
POST | https://api.rees46.com/url/create | application/json

### Query Parameters

This is JSON request. All data must be send as JSON body. Do not forget to set `Content-type: application/json`.

<aside class="notice">
The "code" param is available only for on-premise setup. SaaS doesn't support it.
</aside>

Parameter | Type | Required | Description
--------- | ------- | ------- | -----------
shop_id | String | true | Your API key
shop_secret | String | true | Your secret API key
links | Array | true | List of URLs to shorten. At least 1 element must present.
url | String | true | Source URL to shorted. Must be present in each element if `list` array.
lifetime | Integer | false | Number of days shortened link to be alive. Link will be deleted after this number of days. Min value: `1`. Max value: `90`. Default value: `30`. Try not to use large numbers, because number of unique shortened URLs is limited.
code | String | false | Use `code` property to manually create links with specified URL. Keep in mind: every time you set `code` manually, it overrides previous link with the same code.

