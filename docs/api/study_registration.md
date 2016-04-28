## Study registration
JSON API for study registration

##### Request Fields
* `identifier`: String identifier (typically a study or protocol number)
* `name`: Human readable study name
##### Response Fields


#### Example 
###### URL: `https://cerebralcortex/participants`
###### Request: POST
```
{
    "identifier": "Study XYZ",
    "name": "Study Name"
}
```
###### Response
```
{
  "id": 4,
  "identifier": "Study XYZ",
  "name": "Study Name",
  "created_at": "2016-04-18T20:09:00.286Z",
  "updated_at": "2016-04-18T20:09:00.286Z"
}
```

#### Example 
###### URL: `https://cerebralcortex/participants`
###### Request: POST
```
{
    "identifier": "Participant Name/Identifier",
    "id": "a37fbcab-0f90-4dd3-907d-f0cb3f247302"
}
```
###### Response
```
{
  "id": "a37fbcab-0f90-4dd3-907d-f0cb3f247302",
  "identifier": "Participant Name/Identifier",
  "created_at": "2016-04-28T01:56:38.217Z",
  "updated_at": "2016-04-28T01:56:38.217Z"
}
```
