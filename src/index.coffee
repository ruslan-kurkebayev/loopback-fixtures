fixtureLoader = require './fixtures-loader'
merge = require 'merge'

module.exports = (app, options) ->
  options = merge
    fixturePath: '/fixtures/data/'
    append: false
    autoLoad: false
  , options

  loadFixtures = ->
    if not options.append
      fixtureLoader.purgeDatabase app.models
      .then ->
        console.log 'Data purged'
        fixtureLoader.loadFixtures app.models, options.fixturePath
    else
      fixtureLoader.loadFixtures app.models, options.fixturePath

  if options.autoLoad
    loadFixtures()

  app.loadFixtures = ->
    loadFixtures()
  
  app.loadFixturesFromPath: (models, fixturesPath) ->
    fixtureLoader.loadFixtures app.models, options.fixturePath
