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
# To be done
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
## User searched something
## User added product to cart
## User removed product from cart
## User purchased products 
## User added product to favorites 
## User removed product from favorites 
