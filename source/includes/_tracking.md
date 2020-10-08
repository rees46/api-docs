# Events tracking

You have to track all user's behavior to get real time statistics and user's segmentation.

The platform provides different kinds of events:

- pre-defined events for main reports and segmentation
- user defined events

Events can be tracked in default mode (user did something) and assisted mode (user did something with help of some platform's instruments: search, push, email, recommendations, etc).

To track assisted events, you need to user `recommendedBy` (or `recommended_by`, depending on SDK) params.

## Required params

All events require at least these parameters:

Parameter | Type | Required | Description
--------- | ------- | -------  | -----------
shop_id | String | true | Your API key
did | String | true | Device ID
seance | String | true | User's current session
event | String | true | Type of an event

SDKs already handle these parameters out of the box. 

## User viewed a product

```shell
#Full request without widget recommendation identifiers
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=view&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&item_id[0]=PRODUCT_ID&is_available[0]=PRODUCT_AVAIBILITY[0 or 1]'

#Full request without widget recommendation identifiers
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=view&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&item_id[0]=PRODUCT_ID&is_available[0]=PRODUCT_AVAIBILITY[0 or 1]&recommended_by=dynamic&recommended_code=UNIQUE_RECOMMENDER_CODE'

#Short request with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=view&shop_id=SHOP_ID&did=DEVICE_ID&item_id[0]=PRODUCT_ID'
```

```javascript

// Simple track
r46('track', 'view', {
    id: 37,
    stock: true
});

// Also notify the product is in stock (if it was not in stock)
r46('track', 'view', {
    id: 37,
    stock: true
});

// Or not in stock now (to prevent recommending it on the next requests)
r46('track', 'view', {
    id: 37,
    stock: false
});

// Track if product was viewed after click on product recommendations  
r46('track', 'view', {
    id: 37,
    recommended_by: 'dynamic',
    recommender_code: 'jkIWdXSRfwVyK'
});

// Track if product was viewed after click on suggest results  
r46('track', 'view', {
    id: 37,
    recommended_by: 'instant_search',
});

// ... or on full results  
r46('track', 'view', {
    id: 37,
    recommended_by: 'full_search',
});

```

```swift

```

Send this event when user opens product's details page.



## User viewed a category

```shell
#Full request
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=category&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&category_id=CATEGORY_ID'

#Short request with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=category&shop_id=SHOP_ID&did=DEVICE_ID&category_id=CATEGORY_ID'
```

```javascript
r46('track', 'category', category_id);
```

Send this event when user opens category page.



## User searched something

```shell
#Full request
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=search&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&search_query=URL_ENCODED_SEARCH_QUERY'

#Short request with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=search&shop_id=SHOP_ID&did=DEVICE_ID&search_query=URL_ENCODED_SEARCH_QUERY'
```

```javascript
r46('track', 'search', search_query);
```

## User added product to cart
```shell
#Full request for a single product without widget recommendation identifiers
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=cart&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&item_id[0]=PRODUCT_ID&is_available[0]=PRODUCT_AVAILABILITY[0 or 1]&amount[0]=PRODUCT_QUANTITY'

#Full request for a single product with widget recommendation identifiers
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=cart&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&item_id[0]=PRODUCT_ID&is_available[0]=PRODUCT_AVAILABILITY[0 or 1]&amount[0]=PRODUCT_QUANTITY&recommended_by=dynamic&recommended_code=UNIQUE_RECOMMENDER_CODE'

#Short request for a single product with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=cart&shop_id=SHOP_ID&did=DEVICE_ID&item_id[0]=PRODUCT_ID&is_available[0]=PRODUCT_AVAILABILITY[0 or 1]&amount[0]=PRODUCT_QUANTITY'

#Full request to send the full current cart
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=cart&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMEN[A or B]&item_id[0]=1ST_PRODUCT_ID&amount[0]=1ST_PRODUCT_QUANTITY&item_id[1]=2ND_PRODUCT_ID&amount[1]=2ND_PRODUCT_QUANTITY&...&item_id[LAST_INDEX]=LAST_PRODUCT_ID&amount[LAST_INDEX]=LAST_PRODUCT_QUANTITY&full_cart=true'
```

```javascript
//Short request for a single product
r46('track', 'cart', id);

//Full request for a single product with widget recommendation identifiers
r46('track', 'cart', {
    id: PRODUCT_ID,
    amount: PRODUCT_QUANTITY,
    stock: true,
    recommended_by: 'dynamic',
    recommended_code: 'UNIQUE_RECOMMENDER_CODE'
});

//Full request to send the full current cart
r46('track', 'cart', [
    {
        id: 1ST_PRODUCT_ID,
        amount: 1ST_PRODUCT_QUANTITY
    },
    ...
    {
        id: LAST_PRODUCT_ID,
        amount: LAST_PRODUCT_QUANTITY
    }
]);

```
## User removed product from cart
```shell
#Full request
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=remove_from_cart&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&item_id[0]=PRODUCT_ID'

#Short request for a single product with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=remove_from_cart&shop_id=SHOP_ID&did=gN7WW9zXpM&item_id[0]=PRODUCT_ID'
```
```javascript
//Full request for a single product
r46('track', 'remove_from_cart', product_id);
```
## User purchased products 
```shell
#Full request
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=purchase&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&order_id=ORDER_NUMBER&order_price=TOTAL_ORDER_PRICE&item_id[0]=1ST_PRODUCT_ID&amount[0]=1ST_PRODUCT_QUANTITY&price[0]=1ST_PRODUCT_PRICE&is_available[0]=1ST_PRODUCT_AVAILABILITY[0 or 1]&item_id[1]=2ND_PRODUCT_ID&amount[1]=2ND_PRODUCT_QUANTITY&price[1]=2ND_PRODUCT_PRICE&is_available[1]=2ND_PRODUCTAVAILABILITY[0 or 1]&...&item_id[LAST_INDEX]=LAST_PRODUCT_ID&amount[LAST_INDEX]=LAST_PRODUCT_QUANTITY&price[LAST_INDEX]=LAST_PRODUCT_PRICE&is_available[LAST_INDEX]=LAST_PRODUCTAVAILABILITY[0 or 1]'

#Short request with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=purchase&shop_id=SHOP_ID&did=DEVICE_ID&item_id[0]=1ST_PRODUCT_ID&amount[0]=1ST_PRODUCT_QUANTITY&item_id[1]=2ND_PRODUCT_ID&amount[1]=2ND_PRODUCT_QUANTITY&...&item_id[LAST_INDEX]=LAST_PRODUCT_ID&amount[LAST_INDEX]=LAST_PRODUCT_QUANTITY'
```
```javascript
//Full request
r46('track', 'purchase', {
    products: [
        {id: 37, price: 318, amount: 3, stock: true},
        {id: 187, price: 5000, amount: 1, stock: false}
    ],
    order: 'N318',
    order_price: 29999
});
```
## User added product to favorites 
```shell
#Full request
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=wish&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&item_id[0]=PRODUCT_ID'

#Short request with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=wish&shop_id=SHOP_ID&did=DEVICE_ID&item_id[0]=PRODUCT_ID'
```
```javascript
r46('track', 'wish', product_id);
```
## User removed product from favorites 
```shell
#Full request
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=remove_wish&shop_id=SHOP_ID&did=DEVICE_ID&seance=SEANCE_ID&segment=SEGMENT[A or B]&item_id[0]=PRODUCT_ID'

#Short request with minimum required parameters
curl 'http://api.rees46.com/push' \
    -X 'POST' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw 'event=remove_wish&shop_id=SHOP_ID&did=DEVICE_ID&item_id[0]=PRODUCT_ID'
```
```javascript
r46('track', 'remove_wish', product_id);
```
