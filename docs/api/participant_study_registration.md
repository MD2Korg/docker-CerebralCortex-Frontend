## Participant-Study registration
JSON API for registering an existing participant in and existing study

##### Request Fields
* `participant_id`: UUID from `participant_registration.id` response 
* `study_id`: Integer from `study_registration.id` response

##### Response fields
* `id`: Integer
* `participant_id`: UUID
* `study_id`: Integer
* `created_at`: DateTime
* `updated_at`: DateTime


#### Example 
###### URL: `https://cerebralcortex/studies`
###### Request: POST
```
{
    "participant_id": "b1c966b4-06c8-4ebd-9aee-67bcfd38d0d6",
    "study_id": 4
}
```
###### Response
```
{
  "id": 19,
  "participant_id": "b1c966b4-06c8-4ebd-9aee-67bcfd38d0d6",
  "study_id": 4,
  "created_at": "2016-04-28T02:15:04.213Z",
  "updated_at": "2016-04-28T02:15:04.213Z"
}
```