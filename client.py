#!/usr/bin/python3

import os
import discord
from dotenv import load_dotenv
import re

load_dotenv()
TOKEN = os.getenv('DISCORD_TOKEN')
GUILD = os.getenv('DISCORD_GUILD')

intents = discord.Intents().all()
intents.presences = False

client = discord.Client(intents=intents)

@client.event 
async def on_ready():
    guild = discord.utils.get(client.guilds, name=GUILD)
    print(f'{client.user} is connected to the following guild:')
    print(f'guild name: {guild.name}(id: {guild.id})')

@client.event
async def on_message(message):
    if message.author == client.user:
        return

    if message.author.id == 172002275412279296 and re.match('You have \d+ votes available! Type t!vote for more details\.', message.content):
        print(f'delete message {message.id} from user {message.author.name}')
        await message.delete()

@client.event
async def on_error(event, *args, **kwargs):
    with open('err.log', 'a') as f:
        if event == 'on_message':
            f.write(f'Unhandled message: {args[0]}\n')
        else:
            raise

client.run(TOKEN)

