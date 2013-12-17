# Description:
#   A way to interact with the Google Web API.
#
# Commands:
#   hubot google [me] <query> - Query Google websearch get random result

module.exports = (robot) ->
  robot.respond /(google)( me)? (.*)/i, (msg) ->
    getWeb msg, msg.match[3], (title, url) ->
      msg.send title
      msg.send url

getWeb = (msg, query, cb) ->
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  msg.http('http://ajax.googleapis.com/ajax/services/search/web')
    .query(q)
    .get() (err, res, body) ->
      searches = JSON.parse(body)
      results = searches.responseData?.results
      if results?.length > 0
        result  = msg.random results
        cb result.titleNoFormatting, result.url
