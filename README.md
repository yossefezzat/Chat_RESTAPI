## README

Ruby on Rails Chat-RestApi running on Docker using mysql, redis, sidekiq, elasticsearch.

### Environment

* Ruby v2.7
* Rails v5
* Elasticsearch 7.17
* Mysql 5.7
* Redis 5.0
* sideKiq 

### Requirements

* Docker
* Docker compose

### Run

```bash
$ docker compose up -d --build
```
Docker will expose Port: `4000` run in Host: `localhost` :partying_face:

<!-- ### Chat API
This service exposes these endpoints

```
Verb    URI Pattern
----    -----------

GET     /api/v1/applications/
POST    /api/v1/applications/
PATCH   /api/v1/applications/{app_key}

GET     /api/v1/applications/{app_key}/chats
GET     /api/v1/applications/{app_key}/chats/{chat_number}
POST    /api/v1/applications/{app_key}/chats

GET     /api/v1/applications/{app_key}/chats/{chat_number}/messages
POST    /api/v1/applications/{app_key}/chats/{chat_number}/messages

GET     /api/v1/applications/{app_key}/chats/{chat_number}/messages/search?query={keyword}
``` -->


# CHAT REST API

The REST API to the chat app is described below.

## Get list of Things

### Request

`GET /api/v1/applications`

### Response

    "status": "SUCCESS",
    "data": [
        {
            "name": "app_redis 1",
            "app_key": "Qo6sxrAudRKd2aDPm4PM3Xw9",
            "chat_count": 8,
            "created_at": "2022-06-11T16:55:29.000Z",
            "updated_at": "2022-06-11T18:50:02.000Z"
        }
    ]

### Request

`POST  /api/v1/applications/`

#### Request Body

    {
        "name": "<App name>"
    }

### Response

    "status": "SUCCESS",
    "data": [
        {
            "name": "<App name>",
            "app_key": "<App Token>",
            "chat_count": <Chat Count>,
            "created_at": "<Created Date>",
            "updated_at": "<Updated Date>"
        }
    ]


### Request

`PATCH /api/v1/applications/{app_key}`

#### Request Body

    {
        "name": "<App name>"
    }

### Response

    "status": "SUCCESS",
    "data": [
        {
            "name": "<App name>",
            "app_key": "<App Token>",
            "chat_count": <Chat Count>,
            "created_at": "<Created Date>",
            "updated_at": "<Updated Date>"
        }
    ]


### Request

`GET  /api/v1/applications/{app_key}/chats`

### Response

    {
        "data": [
            {
                "number": 1,
                "message_count": 4,
                "created_at": "2022-06-11T16:55:46.000Z",
                "updated_at": "2022-06-11T17:00:03.000Z"
            },
            {
                "number": 2,
                "message_count": 2,
                "created_at": "2022-06-11T16:55:47.000Z",
                "updated_at": "2022-06-11T18:52:03.000Z"
            }
    }


### Request

`GET   /api/v1/applications/{app_key}/chats/{chat_number}`

### Response

    {
        "data": [
            {
                "number": 1,
                "message_count": 4,
                "created_at": "2022-06-11T16:55:46.000Z",
                "updated_at": "2022-06-11T17:00:03.000Z"
            },
    }


### Request

`POST  /api/v1/applications/{app_key}/chats`

### Response

    {
        "number": `<new chat number>`
    }

### Request

`GET  /api/v1/applications/{app_key}/chats/{chat_number}/messages`

### Response
    {
    "STATUS": "SUCCESS",
        "messages": [
            {
                "body": "message content",
                "created_at": "2022-06-11T16:56:08.000Z",
                "updated_at": "2022-06-11T16:56:08.000Z"
            },
            {
                "body": "message content",
                "created_at": "2022-06-11T16:56:11.000Z",
                "updated_at": "2022-06-11T16:56:11.000Z"
            },
            {
                "body": "message content",
                "created_at": "2022-06-11T16:56:13.000Z",
                "updated_at": "2022-06-11T16:56:13.000Z"
            },
            {
                "body": "message content",
                "created_at": "2022-06-11T16:56:17.000Z",
                "updated_at": "2022-06-11T16:56:17.000Z"
            }
        ]
    }


### Request

`POST  /api/v1/applications/{app_key}/chats/{chat_number}/messages`

### Response
    {
    "STATUS": "SUCCESS",
        {
            "number": `<message number>`
            "body": "message content",
            "created_at": "2022-06-11T16:56:08.000Z",
            "updated_at": "2022-06-11T16:56:08.000Z"
        }
    }
    }


### Request

`GET  /api/v1/applications/{app_key}/chats/{chat_number}/search?query={keyword}`

### Response

    [
        {
            "body": "{keyword}",
            "created_at": "2022-06-11T16:56:17.000Z",
            "updated_at": "2022-06-11T16:56:17.000Z"
        }
    ]

