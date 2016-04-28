## Data point bulk loader
JSON API for data point bulk loading

The URL determines where data is persisted. 
* Postgresql (datapoints)
* Postgresql and Cassandra (rawdatapoints)

##### Request Structure
```
{
    "datastream_id": Integer from datasource_registration process,
    "data": [
        {
            "dateTime": Long milliseconds since 1970,
            "offset": Long offset in milliseconds from UTC to current timezone,
            "sample": Array of JsonObjects
        },
        ...
    ]
}
```
##### Response fields
* `status`: Enum: (OK, ERROR)
* `message`: String
* `count`: Integer indicating number of entries processed


#### Example 
###### URL: `https://cerebralcortex/datapoints/bulkload` or `https://cerebralcortex/rawdatapoints/bulkload`
###### Request: POST
```
{
    "datastream_id": 5,
    "data": [
        {
            "dateTime": 1455862218000,
            "offset": -21600000,
            "sample": [1,2,3,4]
        },
        {
            "dateTime": 1455862219000,
            "offset": -21600000,
            "sample": [
                {
                    "foo":"bar"
                },
                {
                    "foo":"bar"
                }
            ]
        }
    ]
}
```

###### Response
```
{
  "status": "ok",
  "message": "Successfully loaded datapoints",
  "count": 2
}
```