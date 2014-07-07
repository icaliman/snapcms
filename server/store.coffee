liveDbMongo = require 'livedb-mongo'
coffeeify = require 'coffeeify'

module.exports = (derby) ->

  derby.use require 'racer-bundle'


  redisClient = require('redis').createClient()
  redisClient.select process.env.REDIS_DB

  store = derby.createStore
    db: liveDbMongo process.env.MONGO_URL + '?auto_reconnect', {safe: true}
    redis: redisClient

  store.on 'bundle', (browserify) ->

    browserify.transform {global: true}, coffeeify

    pack = browserify.pack

    browserify.pack = (opts) ->
      detectTransform = opts.globalTransform.shift()
      opts.globalTransform.push detectTransform
      pack.apply this, arguments

  store

