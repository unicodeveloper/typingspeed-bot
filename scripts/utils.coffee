sanitizeSpaces = (blurb) ->
  return blurb.match(/\S+/g).join(' ')

module.exports = {
  sanitizeSpaces: sanitizeSpaces
}