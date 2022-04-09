#!/usr/bin/python3

import os
from discord.ext import commands
from dotenv import load_dotenv
import re

load_dotenv()
TOKEN = os.getenv('DISCORD_TOKEN')
# GUILD = os.getenv('DISCORD_GUILD')

# intents = discord.Intents().all()
# intents.presences = False

bot = commands.Bot(command_prefix='b!')

@bot.event
async def on_ready():
    print('ready')

@bot.event
async def on_ctx(ctx):
    print(ctx.author, ctx.user)
    if ctx.author == ctx.user:
        return

    if ctx.author.id == 222315460182409217 and re.match('You have \d+ votes available! Type t!vote for more details\.', ctx.content):
        print(f'delete ctx {ctx.id} from user {ctx.author.name}')
        await ctx.delete()

@bot.event
async def on_error(event, *args, **kwargs):
    with open('err.log', 'a') as f:
            f.write(f'Unhandled ctx: {args[0]}\n')

bot.run(TOKEN)