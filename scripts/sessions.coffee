moment = require 'moment'
paragraphs = require './paragraphs'


createSession = (slack_id, paragraph_index, brain) ->
  newSession = {start_time: moment().unix(), paragraph_index: paragraph_index}
  brain.set slack_id, newSession
  return newSession

getSession = (slack_id, brain) ->
  return brain.get slack_id

deleteSession = (slack_id, brain) ->
  brain.set slack_id, {}

module.exports = {
  createSession: createSession,
  getSession: getSession
}
