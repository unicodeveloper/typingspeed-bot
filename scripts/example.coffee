#   Typingspeed Bot
#   Crafted at Andela
#   Integrated with Slack
#
compare     = require './compare'
moment      = require 'moment'
paragraphs  = require './paragraphs'
sessions    = require './sessions'
utils       = require './utils',
help        = require './help'

module.exports = (robot) ->

  robot.respond /typing/i, (msg) ->
    response = "Hello friend :grin: would you like to upgrade your typing speed?
                A timer starts immediately you receive a paragraph.
                Enter `help` to know more about how to operate typingspeedbot.
                Enter `ready` to get a random paragraph!"
    msg.send utils.sanitizeSpaces response

  robot.respond /ready/i, (msg) ->
    paragraph_index = Math.floor(Math.random() * paragraphs.length)
    newSession = sessions.createSession msg.message.user.name, paragraph_index, robot.brain
    response = paragraphs[paragraph_index]
    msg.send utils.sanitizeSpaces response
    response = ""

  #listen until the user types 'begin'
  robot.respond /begin/i, (msg) ->

    slack_id = msg.message.user.name
    end_time = moment().unix()
    session  = sessions.getSession slack_id, robot.brain
    if !session
      response = "You do not have any active sessions with me.....yet :smirk: ;
                  To start one, enter `ready`"
      msg.reply utils.sanitizeSpaces response
    else
      results  = compare.compareOccurences paragraphs[session.paragraph_index], msg.message.text
      duration = end_time - session.start_time
      speed    = Math.floor((results.hits / duration) * 60)
      if duration <= 25
        response = "It took you #{duration} seconds to type the paragraph.
                     You had typed #{results.misses} words wrong or ommitted them.
                     `99% probability you cheated or copied and pasted. These are the signs of a thief,
                     a scammer and we don't breed these kinda persons in Andela`.
                     Please try again, but honestly this time around."
      else
        response = "It took you #{duration} seconds to type the paragraph.
                     You had typed #{results.misses} words wrong or ommitted them.
                     You typed #{results.hits} word(s) correctly.
                     Your typing speed is #{speed} word(s) per minute"
      msg.reply utils.sanitizeSpaces response

  #Spills out custome typingspeed bot help commands
  robot.respond /help/i, (msg) ->

    emit = help.join "\n"
    msg.send emit
