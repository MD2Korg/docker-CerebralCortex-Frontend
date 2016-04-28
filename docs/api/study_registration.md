## Study registration
JSON API for study registration

##### Request Fields
* `identifier`: String identifier (typically a study or protocol number)
* `name`: Human readable study name

##### Response fields
* `id`: Integer
* `identifier`: String
* `name`: String
* `created_at`: DateTime
* `updated_at`: DateTime


#### Example 
###### URL: `https://cerebralcortex/studies`
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