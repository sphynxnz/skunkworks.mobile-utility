/**
 * mobileutility
 * -------------
 * Mobile Utility API implementation in nodejs.
 * Includes ticket checking and stores finder
 * --
 * flpc: 2017.06
 */

/**
* Server composer for hapi.js
* @const Glue
*/
const Glue = require('glue')

/**
 * @const path
 */
const path = require('path')

/**
 * Server configuration
 * @const manifest
 */
const manifest = require('./config/manifest')

/**
 * Glue options, only using path to plugin directory
 * @const options
 */
const options = {
  relativeTo: path.join(__dirname, '/plugin')
}

/**
 * @function startServer -  Start hapi.js server once all the server configuration has been 'Glued' together
 * @param {Object} server - Hapi js server object
 */
function startServer (server) {
  try {
    server.log('info', 'In start server...')
    server.start((err) => {
      if (err) {
        server.log('error', 'err:' + err)
        throw err
      }
      server.log('info', 'Server started...env=' + server.settings.app.env.id)
    })
  } catch (err) {
    server.log('error', err)
    throw (err)
  }
}

/**
 * Builds the server configuration based on manifest
 * @param {Object} manifest - contains hapi js server configurations
 * @param {Object} options - configuration parameters for the Glue function
 * @param {function(Object err, Object server)} anonymous - callback for Glue, returns err on failure, server on success
 */
Glue.compose(manifest, options, (err, server) => {
  server.log('info', 'In glue...')
  if (err) {
    server.log('error', 'Error in glue... ' + err)
    throw new Error(err)
  }
  startServer(server)
})
