## Datasource registration
JSON API for data source registration

##### Request Structure
```
{
    "participant_id": UUID,
    "datasource": {
        "type": String,
        "id" (optional): String,
        "metadata" (optional): JsonObject representing a ,
        "platform" (optional): {
            "type": String,
            "id": String,
            "metadata": JsonObject representing a HashMap
        },
        "application" (optional): {
            "type": String,
            "id": String,
            "metadata": JsonObject representing a
        },
        "platform" (optional): {
            "type": String,
            "id": String,
            "metadata": JsonObject representing a
        },
        "platformapp" (optional): {
            "type": String,
            "id": String,
            "metadata": JsonObject representing a
        },
        "dataDescriptors" (optional): [
            {
                JsonObject for each item in the datapoint sample
            },
            ...
        ]
    }
}
```
##### Response fields
* `status`: Enum: (OK, ERROR)
* `message`: String
* `datastream_id`: Integer


#### Example 
###### URL: `https://cerebralcortex/datasources/register`
###### Request: POST
```
{
    "participant_id": "b1c966b4-06c8-4ebd-9aee-67bcfd38d0d6",
    "datasource": {
        "type": "MEMORY",
        "platform": {
            "type": "PHONE",
            "metadata": {
                "OPERATING_SYSTEM": "5.1.1",
                "MODEL": "SAMSUNG-SM-G900A",
                "MANUFACTURER": "samsung",
                "NAME": "Phone"
            }
        },
        "application": {
            "id": "org.md2k.phonesensor",
            "metadata": {
                "VERSION_NAME": "0.8.0",
                "VERSION_NUMBER": "11"
            }
        },
        "dataDescriptors": [
            {
                "UNIT": "megabyte",
                "DESCRIPTION": "Size of the memory",
                "FREQUENCY": "1.0 Hz",
                "MAX_VALUE": "2048",
                "MIN_VALUE": "0",
                "DATA_TYPE": "float",
                "NAME": "Size"
            },
            {
                "UNIT": "megabyte",
                "DESCRIPTION": "Available memory",
                "FREQUENCY": "1.0 Hz",
                "MAX_VALUE": "2048",
                "MIN_VALUE": "0",
                "DATA_TYPE": "float",
                "NAME": "Available"
            }
        ],
        "metadata": {
            "DESCRIPTION": "measures usage of memory",
            "FREQUENCY": "1.0 Hz",
            "DATA_TYPE": "org.md2k.datakitapi.datatype.DataTypeFloatArray",
            "NAME": "Memory"
        }
    }
}
```

###### Response
```
{
  "status": "ok",
  "message": "Successfully loaded datasource",
  "datastream_id": "908"
}
```