# Urod-parser-3

[![Build Status](https://travis-ci.org/dluhhbiu/urod-parser-3.svg?branch=master)](https://travis-ci.org/dluhhbiu/urod-parser-3)
[![codecov](https://codecov.io/gh/dluhhbiu/urod-parser-3/branch/master/graph/badge.svg)](https://codecov.io/gh/dluhhbiu/urod-parser-3)

Parsing and sending news

[Subscribe](https://t.me/urodru)

The app requires several env variables:
```bash
DATABASE_URL=postgres://user:password@host:port/database_name
CHAT_ID=changeme 
BOT=changeme
```
Create `.env` file and add the example above for locally running. 

If you don't know where take personal `chat_id` for sending yourself messages, so:

- Start a chat with your bot (I mean button `/start` and one message)
- Do request through browser or curl `https://api.telegram.org/bot<yourtoken>/getUpdates` 
- You will find your last messages and your personal `chat_id` 
