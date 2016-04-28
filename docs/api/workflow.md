## Workflow for Cerebral Cortex API
JSON API

#### Register Participant 
###### URL: `https://cerebralcortex/participants`
###### Request: POST
```
{
    "identifier": "Participant Name/Identifier"
}
```

#### Register Study
###### URL: `https://cerebralcortex/studies`
###### Request: POST
```
{
    "identifier": "Study XYZ",
    "name": "Study Name"
}
```

#### Register Participant in Study
###### URL: `https://cerebralcortex/studies/register_participant`
###### Request: POST
```
{
    "participant_id": "b1c966b4-06c8-4ebd-9aee-67bcfd38d0d6",
    "study_id": 4
}
```

#### Register Data Source
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

#### Load data for each data stream
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