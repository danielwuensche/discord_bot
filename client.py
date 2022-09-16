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
    try:
        conn = sqlite3.connect(db_file)
        return conn
    except sqlite3.Error as e:
        print(e)


def get_catch_id(conn, catch_name):
    sql = ''' SELECT catch_id 
                FROM catch 
                WHERE catch_name = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch_name,))

    rows = cur.fetchall()
    return [x for i in rows for x in i]


def add_catch(conn, catch_name, catch_type_id):
    sql = ''' INSERT INTO catch(catch_name,catch_type_id)
                VALUES(?,?) '''
    cur = conn.cursor()
    cur.execute(sql, (catch_name, catch_type_id))
    conn.commit()
    return cur.lastrowid


def get_catch_type_id(conn, catch_type_name):
    sql = ''' SELECT catch_type.catch_type_id
                FROM catch_type
                WHERE catch_type_name = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch_type_name,))

    rows = cur.fetchall()
    return [x for i in rows for x in i]


def get_catch_type_name(conn, catch_name):
    sql = ''' SELECT catch_type.catch_type_name 
                FROM catch
                JOIN catch_type ON catch_type.catch_type_id = catch.catch_type_id
                WHERE catch_name = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch_name,))

    rows = cur.fetchall()
    return [x for i in rows for x in i]


def get_text_catch(conn, catch_name):
    sql = ''' SELECT text.text AS text 
                FROM _text_catch
                JOIN text ON _text_catch.text_id = text.text_id
                JOIN catch ON _text_catch.catch_id = catch.catch_id
                WHERE catch_name = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch_name,))

    rows = cur.fetchall()
    return [x for i in rows for x in i]


def get_text_catch_type(conn, catch_type_name):
    sql = ''' SELECT text.text AS text 
                FROM _text_catch_type
                JOIN text ON _text_catch_type.text_id = text.text_id
                JOIN catch_type ON _text_catch_type.catch_type_id = catch_type.catch_type_id
                WHERE catch_type_name = ? '''
    cur = conn.cursor()
    cur.execute(sql, (catch_type_name,))

    rows = cur.fetchall()
    return [x for i in rows for x in i]


def get_combo(conn, guild, channel):
    sql = ''' SELECT * 
                FROM combo
                WHERE guild = ?
                    AND channel = ? '''
    cur = conn.cursor()
    cur.execute(sql, (guild, channel))

    rows = cur.fetchall()
    return rows


def create_combo(conn, guild, channel, catch_id, count):
    sql = ''' INSERT INTO combo(guild,channel,catch_id,count)
                VALUES(?,?,?,?) '''
    cur = conn.cursor()
    cur.execute(sql, (guild, channel, catch_id, count))
    conn.commit()
    return cur.lastrowid


def update_combo(conn, guild, channel, catch_id, count):
    sql = ''' UPDATE combo
                SET count = ?,
                    catch_id = ?
                WHERE
                    guild = ?
                    AND channel = ? '''
    cur = conn.cursor()
    cur.execute(sql, (count, catch_id, guild, channel))
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


#
# logging
#

# set up logging
logger = logging.getLogger('discord')
logger.setLevel(logging.INFO)
handler = logging.FileHandler(filename='/'.join([basepath, 'client.log']), encoding='utf-8', mode='w')
handler.setFormatter(logging.Formatter('%(asctime)s:%(levelname)s:%(name)s: %(message)s'))
logger.addHandler(handler)


#
# bot
#

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
    # if message.author.id == 172002275412279296:
    if message.guild.id == 451856527817441301:
        print("message received")
        #
        # delete Tatsu vote spam
        #

        # loop over every embed in the message
        for embed in message.embeds:
            # delete message if it matches the criteria
            if (re.search(r'You have `\d+` votes available! \*\*Type `t!vote` for more details\.', embed.title)
                    or re.search('Earn rewards by voting for Tatsu!', embed.description)):
                print(
                    f'delete message {message.id} from user {message.author.name} in channel #{message.channel.name} of'
                    f' server {message.guild.name}')
                await message.delete()
                break

        #
        # fishing combo stuff
        #

        if "🎣  **|**  **you caught: " in message.content:
            result = re.search(r"🎣 {2}\*\*\|\*\* {2}\*\*you caught: (.+)!\*\*", message.content)
            guild = message.guild.id
            channel = message.channel.id
            catch_name = result.group(1).strip()
            print(f"catch: {catch_name}")
            # fisher = message.author.name

            global conn

            catch_id = get_catch_id(conn, catch_name)
            if len(catch_id) == 1:
                catch_id = catch_id[0]
            print(f"""catch_id: {catch_id if catch_id else "doesn't exist"}""")
            if catch_id:
                catch_type_name = get_catch_type_name(conn, catch_name)[0]
                print(f"catch_type_name: {catch_type_name}")

                if catch_type_name == "rare":
                    text = get_text_catch_type(conn, catch_type_name)
                    response = f"""{catch_name} {catch_type_name} - {str(text[randint(0, len(text) - 1)])}"""
                    await client.get_channel(channel).send(response)

                    combo = get_combo(conn, guild, channel)
                    if combo:
                        delete_combo(conn, guild, channel)
                        print("combo deleted")
                elif catch_type_name == "normal" or catch_type_name == "trash":
                    # combo stuff
                    combo = get_combo(conn, guild, channel)
                    print(f"previous combo: {combo}")
                    if combo:
                        print(
                            f"0: {combo[0][0]}"
                            f"1: {combo[0][1]}"
                            f"2: {combo[0][2]}"
                            f"3: {combo[0][3]}"
                            f"4: {combo[0][4]}")
                    if combo and combo[0][3] == catch_id:
                        count = combo[0][4] + 1
                        if count == 3:
                            # combo reached, send message and delete the combo
                            text = get_text_catch(conn, catch_name) + get_text_catch_type(conn, catch_type_name)
                            if len(text) > 1:
                                response = f"""{catch_name} combo - {str(text[randint(0, len(text) - 1)])}"""
                            elif len(text) == 1:
                                response = f"""{catch_name} combo - {text[0]}"""
                            else:
                                response = f"""{catch_name} combo - text not defined"""
                            await client.get_channel(channel).send(response)
                            delete_combo(conn, guild, channel)
                        else:
                            update_combo(conn, guild, channel, catch_id, count)
                            print("combo updated")
                    elif combo and combo[0][3] != catch_id:
                        count = 1
                        update_combo(conn, guild, channel, catch_id, count)
                        print("combo reset")
                    else:
                        count = 1
                        create_combo(conn, guild, channel, catch_id, count)
                        print("combo created")
                else:
                    await client.get_channel(channel).send(
                        f"{catch_name} - action for type {catch_type_name} not implemented.")
            else:
                catch_type_name = "undefined"
                catch_type_id = get_catch_type_id(conn, catch_type_name)
                if len(catch_type_id) == 1:
                    catch_type_id = catch_type_id[0]
                add_catch(conn, catch_name, catch_type_id)
                await client.get_channel(channel).send(f"{catch_name} - added to database, type currently undefined.")


# write message errors into another file
@client.event
async def on_error(event, *args):
    with open('err.log', 'a') as f:
        if event == 'on_message':
            f.write(f'Unhandled message: {args[0]}\n')
        else:
            raise

client.run(TOKEN)
