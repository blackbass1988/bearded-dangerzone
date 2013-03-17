exports.list = (req, res) ->
    req.session.message = "Hello"
    req.session.token = "12345"
    urlUtils = require(process.cwd() + "/utils").urlUtils
    secret = urlUtils.getSecret(req.query, req.session.token)
    if secret isnt req.query.secret
        res.json {
            "body": req.query,
            "secret": secret,
            "status": "bad request"
        }
    else
        res.json {
            "body": req.query,
            "secret": secret,
            "status": "ok"
        }

exports.carDetail = (req, res, next) ->
    id = req.params.id
    next() if !id
    if !req.session.message
        res.json {
            "status": "bad"
        }
    else
        res.json {
            id: req.params.id
        }
