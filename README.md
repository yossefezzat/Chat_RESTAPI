<!-- # README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* Services (job queues, cache servers, search engines, etc.) -->
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

### Chat API
This service exposes these endpoints

```
Verb    URI Pattern
----    -----------

GET     /api/v1/applications/
<pre>
    <code>{
    "status": "SUCCESS",
    "data": [
        {
            "name": "<App Name>",
            "app_key": "<App token>",
            "chat_count": <Chat count>,
            "created_at": "2022-06-11T20:04:31.000Z",
            "updated_at": "2022-06-11T22:50:03.000Z"
        }
    }</code>

POST    /api/v1/applications/
<pre>
    <code>{
    "status": "SUCCESS",
    "data": [
        {
            "name": "<Application name>",
            "app_key": "<app token>",
            "chat_count": <Chat count>,
            "created_at": "2022-06-11T20:04:31.000Z",
            "updated_at": "2022-06-11T22:50:03.000Z"
        }
    }</code>

PATCH   /api/v1/applications/{app_key}

<pre>
    <code>{
    "status": "SUCCESS",
    "data": [
        {
            "name": "<Updated Application name>",
            "app_key": "<app token>",
            "chat_count": <Chat count>,
            "created_at": "2022-06-11T20:04:31.000Z",
            "updated_at": "2022-06-11T22:50:03.000Z"
        }
    }</code>

GET     /api/v1/applications/{app_key}/chats
<pre>
    <code>{"data": [
        {
            "number": <Chat number>,
            "message_count": <Message count>,
            "created_at": "2022-06-11T20:29:38.000Z",
            "updated_at": "2022-06-11T22:52:07.000Z"
        },
        {
            "number": <Chat number>,
            "message_count": <Message Count>,
            "created_at": "2022-06-11T20:29:39.000Z",
            "updated_at": "2022-06-11T20:29:39.000Z"
        },
    ]}</code>

GET     /api/v1/applications/{app_key}/chats/{chat_number}
<pre>
    <code>{"data": {
            "number": 1,
            "message_count": 15,
            "created_at": "2022-06-11T20:29:38.000Z",
            "updated_at": "2022-06-11T22:52:07.000Z"
            }
    }</code>


POST    /api/v1/applications/{app_key}/chats

GET     /api/v1/applications/{app_key}/chats/{chat_number}/messages
POST    /api/v1/applications/{app_key}/chats/{chat_number}/messages

GET     /api/v1/applications/{app_key}/chats/{chat_number}/messages/search?query={keyword}
```






