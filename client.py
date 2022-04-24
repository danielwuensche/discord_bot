#!/usr/bin/python3

"""
:copyright: (c) 2022 Daniel Wuensche
:license: MIT, see LICENSE for more details.
"""

# bot stuff
import os
import discord
from dotenv import load_dotenv

# logging stuff
import logging

# database stuff
import sqlite3

# logic stuff
import re
from random import randint


# get the script directory
basepath = os.path.abspath(os.path.dirname(__file__))


def create_fish_db():
    conn = sqlite3.connect('fish.db')

    with open('fish.sql', 'r', encoding="utf8") as sql_file:
        conn.executescript(sql_file.read())

    conn.close()


def create_connection(db_file):
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        return conn
    except sqlite3.Error as e:
        print(e)


def get_catch(conn, catch):
    sql = ''' SELECT * FROM catch
                WHERE name = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch))
    
    rows = cur.fetchall()
    return [x for i in rows for x in i] 


def add_catch(conn, catch, catch_type):
    sql = ''' INSERT INTO catch(name,type)
                VALUES(?,?) '''
    cur = conn.cursor()
    cur.execute(sql, (catch, catch_type))
    conn.commit()
    return cur.lastrowid


def get_catch_text(conn, catch):
    sql = ''' SELECT text FROM catch_text
                WHERE catch = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch))
    
    rows = cur.fetchall()
    return [x for i in rows for x in i] 


def get_catch_type(conn, catch):
    sql = ''' SELECT type FROM catch
                WHERE name = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch))
    
    rows = cur.fetchall()
    return [x for i in rows for x in i] 


def get_combo(conn, guild, channel):
    sql = ''' SELECT * FROM combo
                WHERE guild = ?
                    AND channel = ? '''
    cur = conn.cursor()
    cur.execute(sql, (guild, channel))
    
    rows = cur.fetchall()
    return rows


def create_combo(conn, guild, channel, catch, count):
    sql = ''' INSERT INTO combo(guild,channel,catch,count)
                VALUES(?,?,?,?) '''
    cur = conn.cursor()
    cur.execute(sql, (guild, channel, catch, count))
    conn.commit()
    return cur.lastrowid


def update_combo(conn, guild, channel, catch, count):
    sql = ''' UPDATE combo
                SET count = ?,
                    catch = ?
                WHERE
                    guild = ?
                    AND channel = ? '''
    cur = conn.cursor()
    cur.execute(sql, (count, catch, guild, channel))
    conn.commit()


def delete_combo(conn, guild, channel):
    sql = ''' DELETE FROM combo
                WHERE guild = ?
                    AND channel = ? '''
    cur = conn.cursor()
    cur.execute(sql, (guild, channel))
    conn.commit()


if not os.path.isfile('fish.db'):
    create_fish_db()

conn = create_connection('/'.join([basepath, 'fish.db']))


### logging
###########

# set up logging
logger = logging.getLogger('discord')
logger.setLevel(logging.INFO)
handler = logging.FileHandler(filename='/'.join([basepath, 'client.log']), encoding='utf-8', mode='w')
handler.setFormatter(logging.Formatter('%(asctime)s:%(levelname)s:%(name)s: %(message)s'))
logger.addHandler(handler)


### bot
##################

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
        
        ### delete Tatsu vote spam
        ##########################

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


        ### fishing combo stuff
        #######################

        if "🎣  **|**  **you caught: " in message.content:
            result = re.search("🎣  \*\*\|\*\*  \*\*you caught: (.+)!\*\*", message.content)
            guild = message.guild.id
            channel = message.channel.id
            catch = result.group(1)
            # fisher = message.author.name
            
            global conn

            if get_catch(conn, catch):
                catch_type = get_catch_type(conn, catch)[0]

                if catch_type == "rare":
                    text = get_catch_text(conn, catch)
                    response = f"""{catch} rare - {str(text[randint(0, len(text) - 1)])}"""
                    await client.get_channel(channel).send(response)
                    
                    combo = get_combo(conn, guild, channel)
                    if combo:
                        delete_combo(conn, guild, channel)
                elif catch_type == "normal":
                    # combo stuff
                    combo = get_combo(conn, guild, channel)
                    if combo and combo[0][2] == catch:
                        count = combo[0][3] + 1
                        if count == 3:
                            # combo reached, send message and delete the combo
                            text = get_catch_text(conn, catch)
                            if len(text) > 1:
                                response = f"""{catch} combo - {str(text[randint(0, len(text) - 1)])}"""
                            elif len(text) == 1:
                                response = f"""{catch} combo - {text[0]}"""
                            else:
                                response = f"""{catch} combo - text not defined"""
                            await client.get_channel(channel).send(response)
                            delete_combo(conn, guild, channel)
                        else:
                            update_combo(conn, guild, channel, catch, count)
                    elif combo and combo[0][2] != catch:
                        count = 1
                        update_combo(conn, guild, channel, catch, count)
                    else: 
                        count = 1
                        create_combo(conn, guild, channel, catch, count)
                else:
                    await client.get_channel(channel).send(f"{catch} - action for type {catch_type} not implemented.")
            else:
                catch_type = "undefined"
                add_catch(conn, catch, catch_type)
                await client.get_channel(channel).send(f"{catch} - added to database, type currently undefined.")



# write message errors into another file
@client.event
async def on_error(event, *args, **kwargs):
    with open('err.log', 'a') as f:
        if event == 'on_message':
            f.write(f'Unhandled message: {args[0]}\n')
        else:
            raise

client.run(TOKEN)
