## Participant registration
JSON API for participant registration

##### Request fields
* `identifier`: String identifier
* `id` (optional): UUID of this form: a37fbcab-0f90-4dd3-907d-f0cb3f247302

##### Response fields
* `identifier`: String
* `id`: UUID
* `created_at`: DateTime
* `updated_at`: DateTime


#### Example 
###### URL: `https://cerebralcortex/participants`
###### Request: POST
```
{
    "identifier": "Participant Name/Identifier"
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
