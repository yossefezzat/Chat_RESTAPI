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
POST    /api/v1/applications/
PATCH   /api/v1/applications/{app_key}

GET     /api/v1/applications/{app_key}/chats
GET     /api/v1/applications/{app_key}/chats/{chat_number}
POST    /api/v1/applications/{app_key}/chats

GET     /api/v1/applications/{app_key}/chats/{chat_number}/messages
POST    /api/v1/applications/{app_key}/chats/{chat_number}/messages

GET     /api/v1/applications/{app_key}/chats/{chat_number}/messages/search?query={keyword}
```






