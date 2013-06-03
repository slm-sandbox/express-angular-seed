path = require "path"
express = require "express"

config = require './config/config'
db = require './lib/db'
modelFactory = require './lib/models/model'
model = modelFactory db.connect config.db

app = express()
app.configure ()->
  app.use express.bodyParser()
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use require('connect-assets')()
  app.use "/img",express.static path.join(__dirname,"assets/img")
  app.use "/css",express.static path.join(__dirname,"assets/css")


app.get "/",(req,res)->
  res.render("index")
app.get "/subView",(req,res)->
  res.render("subView")

app.get "/get",(req,res)->
  model.find().limit(10).exec (err,data)->
    if err then throw err
    res.send(200,data)

app.post "/post",(req,res)->
  postData = req.body
  console.log postData
  model.create {}, (err)->
    if err then throw err
    res.send(200)



httpServer = app.listen 3006, ->
  console.log "......................................"
  console.log "Environment set to: " + process.env.NODE_ENV
  console.log "Listen to port: " + 3006
  console.log "......................................"

