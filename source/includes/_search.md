# Search

Service provides 2 types of search: instant (typeahead) and full search.

## Instant search

### HTTP Request

`GET https://api.rees46.com/search`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
ssid | true | Session ID of the user. You get it from `init` method in SDK.
shop_id | true | Your API key
seance | true | Temporary user session ID
type | true | In this case: "instant_search"
search_query | true | Search query

## Full search

### HTTP Request

`GET https://api.rees46.com/search`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
ssid | true | Session ID of the user. You get it from `init` method in SDK.
shop_id | true | Your API key
seance | true | Temporary user session ID
type | true | In this case: "full_search"
search_query | true | Search query
limit | false | Limit of results
page | false | Page of results
category_limit | false | How many categories for sidebar filter to return
categories | false | Comma separated list of categories to filter 
extended | false | It's better to use `true` for full search results 
sort_by | false | Sort by parameter: `popular`
locations | false | Comma separated list of locations IDs
brands | false | Comma separated list of brands to filter
filters | false | Optional escaped JSON string with filter parameters. For example: `{"bluetooth":["yes"],"offers":["15% cashback"],"weight":["1.6"]}`


