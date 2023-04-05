# My discord bot
This is a little discord bot, it handles messages of the bot Tatsu (Tatsumaki).

## Features
- delete Tatsu vote reminders
- combo system for Tatsu's fishing game

Feature ideas are always welcome, please create an issue for feature requests or if you find bugs.

## Disclaimer
The code might be messy, I'm not a developer.

## Requirements
You need the python modules listed in [requirements.py](/requirements.py). You can install them via `pip install -r requirements.py`.  
You also need to register a discord bot, follow [the documentation](https://discord.com/developers/docs/getting-started), add the scope `bot` and permissions:
- Read Messages/View Channels
- Send Messages
- Manage Messages

As with all python applications, it's recommended to run it in its own venv. 

## .env File
Configuration happens in the environment file. Create a file named `.env` without any file name extensions with the following content:
```
DISCORD_TOKEN="ODA********************************************************"
VERBOSE=no
```

### TOKEN (mandatory)
This token is used for the bot to connect to discord. Without it, the bot cannot connect at all.

### VERBOSE
If you want the bot to output more information for troubleshooting purposes, add this and set it to `yes`. Output looks like this:
```
message received
catch: 🔧
catch_id: 5
catch_type_name: trash
previous combo: [(4, 320697790768349185, 321025475973742593, 3, 1)]
0: 41: 3206977907683491852: 3210254759737425933: 34: 1
combo reset
```