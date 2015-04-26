# Description:
#   Example scripts for you to examine and try out.
##
##Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
####   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
compare = require './compare'
moment = require 'moment'
paragraphs = require './paragraphs'
sessions = require './sessions'
utils = require './utils'




module.exports = (robot) ->

  robot.respond /typing/i, (msg) ->
    response = "Hello friend :grin: would you like to upgrade your typing speed?
                A timer starts immediately you receive a paragraph.
                You must start by typing 'begin ' before your paragraph so I can detect your response.
                Enter 'ready' to get a random paragraph!
              "
    msg.send utils.sanitizeSpaces response

  robot.respond /ready/i, (msg) ->
    paragraph_index = Math.floor(Math.random() * paragraphs.length)
    newSession = sessions.createSession msg.message.user.name, paragraph_index, robot.brain
    response = paragraphs[paragraph_index]
    msg.send utils.sanitizeSpaces response

    #listen until the user types 'begin'
    robot.respond /begin/i, (msg) ->
      slack_id = msg.message.user.name
      end_time = moment().unix()
      session = sessions.getSession slack_id, robot.brain
      results = compare.compareOccurences paragraphs[session.paragraph_index], msg.message.text
      duration = end_time - session.start_time
      speed = Math.floor((results.hits / duration) * 60)
      response = "It took you #{duration} seconds to type the paragraph.
                 You had typed #{results.misses} words wrong or ommitted them;
                 You also typed #{results.extras} extra words.
                 You typed #{results.hits} words correctly.
                 Your typing speed is #{speed} words per minute"
      msg.reply utils.sanitizeSpaces response



