derby = require 'derby'

errorApp = module.exports = derby.createApp()

errorApp.serverUse module, 'derby-jade'
errorApp.serverUse module, 'derby-stylus'

errorApp.loadViews __dirname + '/../../views/error'
errorApp.loadStyles __dirname + '/../../styles/error/index'
errorApp.loadStyles __dirname + '/../../styles/error/reset'