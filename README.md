Channel Datalogger Server
=========================

API for submitting Data Points grouped by Channels, powered by Rails.

Runs on **rails 4.2.6** using **ruby v2.2.1**.

## HTTP Requests

To view a channel, make the following request:

    curl http://localhost:3000/api/v1/channels/MyChannelName

Where 'MyChannelName' is the name of your channel. Channels cannot be indexed and instead names must be specified in the request.

Responses will look like:

```json
{
  "name" : "MyChannelName",
  "description" : "My channel description",
  "fields" : [
    {
      ...
    }
  ]
}
```

You can request all data points for a given channel using the request:

    curl http://localhost:3000/api/v1/channels/MyChannelName/data_points


## POST Requests

### Create new Channel

    curl -X POST -H "Content-Type:application/json" http://localhost:3000/api/v1/channels/MyChannelName -d @channel.json

contents of channel.json:

```json
{
   "name" : "MyChannelName",
   "description" : "My channel description",
   "fields" : [
      {
        "field_type" : "number",
        "name" : "MyNumberField",
        "description" : "This is the value for the number field.",
        "is_required" : true
      }
   ]
}
```

### Add new Data Point

    curl -X POST -H "Content-Type:application/json" "http://localhost:3000/api/v1/channels/MyChannelName/data_points" -d @data_point.json

contents of data_point.json:

```json
{
  "latitude" : 1.1,
  "longitude" : 2.1,
  "values" : {
    "MyNumberField" : "1"
  }
}
```

Values for Data Points should be sent as strings to ensure they are recorded in the database properly.
