# jc REST API

This project provides a RESTful API server for `jc`.

A demo can be found at: https://jc-api.onrender.com

See also: [jc-web](https://github.com/kellyjonbrazil/jc-web)

## Starting the Server (using a Python venv)
```bash
$ cd jc-restapi
$ source .venv/bin/activate
(.venv) $ python -m app
```
or
```bash
$ cd jc-restapi
$ source .venv/bin/activate
(.venv) $ gunicorn app:app
```

## Client Usage

### Show JC Version
Method: **GET**

URL: `http://<URL>/v1/version`

### List Parsers
Method: **GET**

URL: `http://<URL>/v1/parsers`

### Get Parser Info
Method: **GET**

URL: `http://<URL>/v1/info/<parser>`

### Parse Data
Method: **POST**

URL: `http://<URL>/v1/parse/<parser>`

JSON Request:
```
{
  "raw": bool,        # optional (defaults to false)
  "data": string
}
```
For example, to parse `date` output:
```
$ curl -X POST http://<URL>/v1/parse/date \
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
> Ensure you have properly JSON escaped your command output string. This can
> be done with something like:  `dig | jq -R -s`

`jc` (CLI and Python library) can be found at https://github.com/kellyjonbrazil/jc

## Build the Docker Container

```bash
$ git clone https://github.com/kellyjonbrazil/jc-restapi
$ cd ./jc-restapi
$ ./docker-build.sh
```

Now you can see the list of images:

```bash
$ docker images
REPOSITORY               TAG       IMAGE ID       CREATED              SIZE
kellybrazil/jc-restapi   1.0       5c8c90b5ab98   About a minute ago   68.7MB
kellybrazil/jc-restapi   latest    5c8c90b5ab98   About a minute ago   68.7MB
```

You can also pull the pre-built container from [Docker Hub](https://hub.docker.com/r/kellybrazil/jc-restapi) with `docker pull kellybrazil/jc-restapi`

### Run the Container

```bash
$ docker run -d --name jc-restapi -p 8000:8000 kellybrazil/jc-restapi:1.0
```

or

```bash
$ JC_APP_PORT=8000 docker-compose up -d
```
