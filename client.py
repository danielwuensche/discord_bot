#!/usr/bin/python3

import os
import discord
from dotenv import load_dotenv
import re
import logging

# get the script directory
basepath = os.path.abspath(os.path.dirname(__file__))

# set up logging
logger = logging.getLogger('discord')
logger.setLevel(logging.INFO)
handler = logging.FileHandler(filename='/'.join([basepath, 'client.log']), encoding='utf-8', mode='w')
handler.setFormatter(logging.Formatter('%(asctime)s:%(levelname)s:%(name)s: %(message)s'))
logger.addHandler(handler)

# load env vars from file
load_dotenv()
TOKEN = os.getenv('DISCORD_TOKEN')

# gateway permissions
intents = discord.Intents().all()
intents.presences = False

# create a client
client = discord.Client(intents=intents)

# will be executed after login is finished
@client.event 
async def on_ready():
    print(f'{client.user} is connected to the following guilds:')
    for guild in client.guilds:
        print(f'name: {guild.name} (id: {guild.id})') 

# will be executed on every received message
@client.event
async def on_message(message):
    # check that the message doesn't come from the client itself (prevent message spam loop)
    if message.author == client.user:
        return

    # match messages from bot Tatsumaki
    if message.author.id == 172002275412279296:
        # loop over every embed in the message
        for embed in message.embeds:
            # delete message if it matches the criteria
            if re.search('You have `\d+` votes available! \*\*Type `t!vote` for more details\.', embed.title):
                print(f'delete message {message.id} from user {message.author.name} in channel #{message.channel.name} of server {message.guild.name}')
                await message.delete()
                break
        
            if re.search('Earn rewards by voting for Tatsu!', embed.description):
                print(f'delete message {message.id} from user {message.author.name} in channel #{message.channel.name} of server {message.guild.name}')
                await message.delete()
                break

# write message errors into another file
@client.event
async def on_error(event, *args, **kwargs):
    with open('err.log', 'a') as f:
        if event == 'on_message':
            f.write(f'Unhandled message: {args[0]}\n')
        else:
            raise

client.run(TOKEN)
