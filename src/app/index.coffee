derby = require 'derby'

app = module.exports = derby.createApp 'app', __filename

global.app = app unless derby.util.isProduction

app.use require 'd-bootstrap'
app.serverUse module, 'derby-jade'
app.serverUse module, 'derby-stylus'

app.loadViews __dirname + '/../../views/app'
app.loadStyles __dirname + '/../../styles/app'


app.use require './../../components'


app.get '/', (page) ->
  page.render 'home'


app.proto.init = (model) ->
  if derby.util.isServer
    for name, view of @app.views.nameMap
      target = view.componentFactory?.constructor.prototype.target || view.options?.target
      if target
        model.root.push "_views.#{target}", name