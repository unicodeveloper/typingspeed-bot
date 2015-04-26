# Description:
#   Example scripts for you to examine and try out.
##
##Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
####   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
moment = require 'moment'
paragraphs = require './paragraphs'


module.exports = (robot) ->

  robot.hear /typing/i, (msg) ->
    msg.send "Hello friend :grin: would you like to upgrade your typing speed?
              A timer starts immediately you receive a paragraph.
              You must start by typing 'begin ' before your paragraph so I can detect your response.
              Enter 'ready' to get a random paragraph!
              "

  robot.hear /ready/i, (msg) ->
    paragraph_index = Math.floor(Math.random() * paragraphs.length)
    msg.send paragraphs[paragraph_index]

  robot.hear /whoami/i, (msg) ->
    name = msg.message.user.name
    msg.send name

