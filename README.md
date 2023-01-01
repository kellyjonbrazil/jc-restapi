# jc REST API

This project provides a RESTful API server for `jc`.

## Starting the Server (using a Python venv)
```
$ cd jc-restapi
$ source jc_restapi/bin/activate
(jc_restapi) $ python -m app
```

## Client Usage

## Show JC Version
Method: **GET**

URL: `http://<URL>/v1/version`

### List Parsers
Method: **GET**

URL: `http://<URL>/v1/parsers`

### Get Parser Info
Method: **GET**

URL: `http://<URL>/v1/<parser>/info`

### Parse Data
Method: **POST**

URL: `http://<URL>/v1/<parser>/parse`

JSON Request:
```
{
  "raw": bool,
  "data": string
}
```
For example, to parse `date` output:
```
$ curl -X POST http://<URL>/v1/date/parse \
   -H 'Content-Type: application/json' \
   -d '{
    "raw": false,
    "data": "Sat Dec 31 16:51:50 PST 2022"
   }'
{
  "result": {
    "day": 31,
    "day_of_year": 365,
    "epoch": 1672534310,
    "epoch_utc": null,
    "hour": 4,
    "hour_24": 16,
    "iso": "2022-12-31T16:51:50",
    "minute": 51,
    "month": "Dec",
    "month_num": 12,
    "period": "PM",
    "second": 50,
    "timezone": "PST",
    "timezone_aware": false,
    "utc_offset": null,
    "week_of_year": 52,
    "weekday": "Sat",
    "weekday_num": 6,
    "year": 2022
  }
}
```

`jc` (CLI and Python library) can be found at https://github.com/kellyjonbrazil/jc
