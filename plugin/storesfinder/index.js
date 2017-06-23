/**
 * @const config
 * Plugin specific configuration for storesfinder
 */
const config = require('./config/config.json')

/**
 * @const joi
 * Object schema description language and validator for JavaScript objects
 */
const joi = require('joi')

/**
 * @const csv
 * Utility for loading csv file as array of JSON objects
 */
const csv = require('csvdata')

/**
 * @const findStores
 * Function to find store locations
 */
const findStores = require('./findStores')

/**
 * Regular expressions used to validate store finder input parameters
 */
const uuidFormat = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/

/**
 * Validation rules for ticket check input parameters
 */
const longitude = joi.number().required().precision(8).description('Longitude of current location')
const latitude = joi.number().required().precision(8).description('Latitude of current location')
const maxcount = joi.number().optional().integer().description('Maximum number of stores to return')
const radius = joi.number().optional().precision(6).description('Stores within specified radius in kilometers')
const channelId = joi.number().integer().required().min(1).max(3).description('Channel identifier. Value is 1, 2 or 3')
const source = joi.string().optional().ip().description('IP address where request originated from')
const emailAddress = joi.string().optional().email().description('Player email address')
const deviceId = joi.string().optional().regex(uuidFormat).description('Device ID in uuid v4.0 format')

/**
 * Validation schema for store finder
 */
const querySchemaStoresFinder = joi.object().keys({
  longitude: longitude,
  latitude: latitude,
  maxcount: maxcount,
  radius: radius,
  channelid: channelId,
  source: source,
  emailaddress: emailAddress,
  deviceid: deviceId
}).without('maxcount', 'radius')

/**
 * @function register
 * @param {Object} server - hapi js server
 * @param {Object} options - plugin options
 * @param {function()} next - callback to process next plugin
 */
exports.register = function (server, options, next) {
  /**
   * Add route for the stores finder
   */
  server.log('info', 'Stores finder GET path: ' + options.getpath)
  server.route({
    path: options.getpath,
    method: 'GET',
    handler: require('./storesfinder'),
    config: {
      tags: ['api'],
      validate: {
        query: querySchemaStoresFinder
      }
    }
  });

  /**
   *  Load stores data from CSV file
   */
  (async () => {
    /**
     * The stores data file reference is relative from the location where the server is started.
     * In which case, the value for config.storesDataFile is set to:
     *  ./plugin/storesfinder/config/storesdata.csv
     */
    server.log('info', 'Stores CSV File: ' + config.storesDataFile)
    server.app.storesData = await csv.load(config.storesDataFile)
    /**
     * Assign an id using the index to each record
     */
    server.app.storesData.forEach((store, idx, storeArray) => {
      storeArray[idx] = Object.assign({ id: idx + 1 }, store)
    })
    server.log('info', 'Stores CSV File loaded and assigned IDs')
  })()

  /**
   * Initialise functions for stores finder.
   * This call will save the reference to the findStores function in server.methods object
   */
  findStores.init(server)

  server.log('info', 'Stores finder plugin registered')

  next()
}

/**
 * Define attributes for this plugin
 */
exports.register.attributes = {
  pkg: require('./package.json')
}
