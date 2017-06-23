/**
 * @const config
 * Plugin specific configuration for ticket checker
 */
const config = require('./config/config.json')

/**
 * @const scenarios
 * Online and IK ticket checking result scenarios.
 */
const scenarios = require(config.scenarios)

/**
 * @const misc
 * Miscellaneous configuration used in processing ticket checking results.
 * Includes data such as missing scenarions and product codes.
 */
const misc = require(config.misc)

/**
 * @const messages
 * List of community messages returned to client if ticket is non-winning
 */
const messages = require(config.messages)

/**
 * @const joi
 * Object schema description language and validator for JavaScript objects
 */
const joi = require('joi')

/**
 * @const soap
 * SOAP client library for nodejs
 */
const soap = require('soap')

/**
 * @const checkOnlineTicket
 * Function to check online tickets
 */
const checkOnlineTicket = require('./checkOnlineTicket')

/**
 * @const checkInstantTicket
 * Function to check IK tickets
 */
const checkInstantTicket = require('./checkInstantTicket')

/**
 * Regular expressions used to validate ticket check input parameters
 */
const serialNumberFormat = /^((\d{16})|(\d{22}))$/
const checkDigitsFormat = /^\d{4}$/
const uuidFormat = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/

/**
 * Validation rules for ticket check input parameters
 */
const serialNumber = joi.string().required().regex(serialNumberFormat).description('Online or IK ticket serial number')
const channelId = joi.number().integer().required().min(1).max(3).description('Channel identifier. Value is 1, 2 or 3')
const checkDigits = joi.string().optional().regex(checkDigitsFormat).description('Check digits for IK ticket only')
const source = joi.string().optional().ip().description('IP address where request originated from')
const format = joi.string().optional().description('Barcode format. 1=i2of5, 2=PDF417')
const emailAddress = joi.string().optional().email().description('Player email address')
const deviceId = joi.string().optional().regex(uuidFormat).description('Device ID in uuid v4.0 format')

/**
 * Validation schema for serial number provided as URI parameter using the GET method
 */
const paramSchemaTicketChecker = joi.object().keys({
  serialnumber: serialNumber
})

/**
 * Validation schema for query parameters provided using the GET method version of the API
 */
const querySchemaTicketChecker = joi.object().keys({
  channelid: channelId,
  checkdigits: checkDigits,
  source: source,
  format: format,
  emailaddress: emailAddress,
  deviceid: deviceId
})

/**
 * Validation schema for message body (payload) using the POST method version of the API
 */
const payloadSchemaTicketChecker = joi.object().keys({
  serialNumber: serialNumber,
  channelId: channelId,
  checkDigits: checkDigits,
  source: source,
  format: format,
  emailAddress: emailAddress,
  deviceId: deviceId
})

/**
 * @function register
 * @param {Object} server - hapi js server
 * @param {Object} options - plugin options
 * @param {function()} next - callback to process next plugin
 */
exports.register = function (server, options, next) {
  /**
   * @function createSoapClient - creates the soap client for invoking ESI SOAP Web Service
   * @param {String} url - URL to the ESI SOAP Web Service
   */
  function createSoapClient (url) {
    server.log('info', 'In create soap client...')
    return new Promise((resolve, reject) => {
      soap.createClient(url, (err, client) => {
        if (err) {
          return (reject(err))
        } else {
          return (resolve(client))
        }
      })
    })
  }

  /**
   * Add route for the GET version of the API call to check ticket
   */
  server.log('info', 'GET path: ' + options.getpath)
  server.route({
    path: options.getpath,
    method: 'GET',
    handler: require('./ticketchecker'),
    config: {
      tags: ['api'],
      validate: {
        params: paramSchemaTicketChecker,
        query: querySchemaTicketChecker
      }
    }
  })

  /**
   * Add route for the POST version of the API call to check ticket
   */
  server.log('info', 'POST path: ' + options.postpath)
  server.route({
    path: options.postpath,
    method: 'POST',
    handler: require('./ticketchecker'),
    config: {
      tags: ['api'],
      validate: {
        payload: payloadSchemaTicketChecker
      }
    }
  })

  /**
   * Add route for the heartbeat
   */
  server.log('info', 'Heartbeat path: ' + options.heartbeatpath)
  server.route({
    path: options.heartbeatpath,
    method: 'GET',
    handler: function (request, reply) {
      reply({ app: options.appname, version: options.version, status: 'alive' })
    },
    config: {
      tags: ['api']
    }
  });

  /**
   *  Perform the folloing initialisations and save references in server.app
   *  - Initialise soap client
   *  - Save ticket checking result scenarios
   *  - Save ticket checking miscellaneous data
   *  - Save ticket checking community messages
   */
  (async () => {
    server.log('info', 'ESI URL: ' + server.settings.app.env.esiWsUrl)
    server.app.esiSoapClient = await createSoapClient(server.settings.app.env.esiWsUrl)
    server.log('info', 'esiSoapClient created...')
    server.app.resultScenarios = scenarios
    server.app.communityMessages = messages
    server.app.misc = misc
    server.log('info', 'Scenarios, community messages and miscellaneous data initialised...')
  })()

  /**
   * Initialise functions for online and IK ticket checking.
   * These calls will save the reference to the functions in server.methods object
   */
  checkOnlineTicket.init(server)
  checkInstantTicket.init(server)

  server.log('info', 'Ticket checker plugin registered')

  next()
}

/**
 * Define attributes for this plugin
 */
exports.register.attributes = {
  pkg: require('./package.json')
}
