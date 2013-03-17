exports.getSecret = (requestParams, token) ->
    crypto = require 'crypto'
    shaSum = crypto.createHash 'sha1'
    requestParams = sortParams requestParams
    secret = ""
    requestString = ""
    requestString += concatKeyValue key, value for key, value of requestParams
    requestString += token
    shaSum.update requestString
    secret = shaSum.digest 'hex'
    secret
sortParams = (params) ->
    sortable = []
    console.log params
    for param of params
        sortable.push [param, params[param]]
    sortable = sortable.sort (a,b) ->
        a[1] - b[1]
    newParams = {}
    for param in sortable
        newParams[param] = sortable[param]
    newParams
concatKeyValue = (key, value) ->
    console.log key
    "#{key}=#{value}&" if key isnt "secret"
