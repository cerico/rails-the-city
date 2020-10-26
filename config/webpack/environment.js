const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.insert(
  "Environment",
  new webpack.EnvironmentPlugin(process.env)
)

module.exports = environment
