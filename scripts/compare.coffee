_ = require 'lodash'
paragraphs = require './paragraphs'

getOccurrences = (paragraph) ->
  paragraphArr = paragraph.match(/\S+/g);
  occurences = {};
  _.forEach paragraphArr, (word) ->
    occurences[word] = occurences[word] + 1 || 1;

  return occurences

compareOccurences = (original, user_response) ->
  originalOccurences = getOccurrences(original)
  userResponseOccurences = getOccurrences(user_response)
  numOfMisses = 0;
  numOfExtras = 0;
  numOfHits = 0;
  _.forEach originalOccurences, (value, key) ->
    if !_.has userResponseOccurences, key
      numOfMisses = numOfMisses + value
    else if userResponseOccurences[key] < value
      difference = value - userResponseOccurences[key]
      numOfMisses = numOfMisses + difference
    else if userResponseOccurences[key] > value
      difference = userResponseOccurences[key] - value
      numOfExtras = numOfExtras + difference
    else if userResponseOccurences[key] == value
      numOfHits = numOfHits + value

  return {misses: numOfMisses, extras: numOfExtras, hits: numOfHits}


module.exports = {
  compareOccurences: compareOccurences
}