express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
cars = require './routes/cars'

app = express()

app.configure () ->
  app.use(express.cookieParser())
  app.use(express.session({secret: "secret"}))
  app.set('port', process.env.PORT || 3000)
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.static(path.join(__dirname, 'public')))
  app.use(app.router)

app.configure 'development', () ->
  app.use(express.errorHandler())


app.get('/', routes.index)
app.get '/cars', cars.list
app.get '/cars/:id', cars.carDetail

http.createServer(app).listen app.get('port'), () ->
  console.log("Express server listening on port " + app.get('port'))
