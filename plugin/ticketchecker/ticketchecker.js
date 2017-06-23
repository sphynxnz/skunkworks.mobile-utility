/**
 * @const checkOnlineTicketPromise
 * Import function to check online tickets
 */
const checkOnlineTicketPromise = require('./checkOnlineTicketPromise')

/**
 * @const checkInstantTicketPromise
 * Import function to check IK tickets
 */
const checkInstantTicketPromise = require('./checkInstantTicketPromise')

/**
 * @function setEsiArgs - set a common object to the input parameters from either the GET or POST version of the API
 * @param {Object} request
 */
function setEsiArgs (request) {
  let payload = {}
  /**
   * If request method is GET, then set the payload properties from the request query parameters
   */
  if (request.method === 'get') {
    payload.serialNumber = request.params.serialnumber
    if (request.query.channelid) {
      payload.channelId = request.query.channelid
    }
    if (request.query.checkdigits) {
      payload.checkDigits = request.query.checkdigits
    }
    if (request.query.format) {
      payload.format = request.query.format
    }
    if (request.query.source) {
      payload.source = request.query.source
    }
    if (request.query.emailaddress) {
      payload.emailAddres = request.query.emailaddress
    }
    if (request.query.deviceid) {
      payload.deviceId = request.query.deviceid
    }
  } else {
    /**
     * Else reference the POST method paylod (http message body)
     */
    payload = request.payload
  }
  return (payload)
}

/**
 * @function anonymous - this is the ticket checker plugin
 * @param {Object} request - http request object
 * @param {Object} reply - http reply object
 */
module.exports = function (request, reply) {
  /**
   * Get reference to the hapijs server object which is available from the request object
   */
  let server = request.server

  /**
   * Extract the input parameters based on the HTTP method
   */
  let payload = setEsiArgs(request)

  /**
   * Initialise reference to target ticket check function and input arguments
   */
  let apiCallPromise = null
  let args = {
    ticketSerialNumber: payload.serialNumber,
    channelId: payload.channelId
  }

  /**
   * Serial number length is either 16 for online ticket or 22 for IK ticket.
   * Any other lenght would have been rejected by the validation of the parameters.
   */
  if (payload.serialNumber.length === 16) {
    /**
     * Assign the target ticket check function and input parameters for online ticket checking
     */
    apiCallPromise = checkOnlineTicketPromise
    args.ticketSerialNumber =
      payload.serialNumber.substr(0, 3) + '-' +
      payload.serialNumber.substr(3, 9) + '-' +
      payload.serialNumber.substr(12, 4)
  } else {
    /**
     * Assign the target ticket check function and input parameters for IK ticket checking
     */
    apiCallPromise = checkInstantTicketPromise
    args.ticketSerialNumber =
      payload.serialNumber.substr(0, 3) + '-' +
      payload.serialNumber.substr(3, 5) + '-' +
      payload.serialNumber.substr(8, 3) + '-' +
      payload.serialNumber.substr(11, 7)
    args.checkDigits = payload.serialNumber.substr(18, 4)
  }

  server.log('info', 'args: ' + JSON.stringify(args));

  /**
   * Invoke the target ticket checking function passing the hapijs server and input arguments.
   * Note the use of anonymous async function to allow use of await construct against the
   * asynchronous function apiCallPromise.
   */
  (async () => {
    try {
      /**
       * Successful invocation will return the processed response
       */
      let result = await apiCallPromise({ server, args })
      server.log('info', 'API call successful')
      reply(result.checkResult).header('Content-Type', 'application/json').code(200)
    } catch (error) {
      /**
       * Errors will be caught here and a custom error response is returned
       */
      server.log('info', 'In catch of api call')
      server.log('error', error.toString())
      let errorResponse = {
        response: {
          status: 'failure',
          code: 7000,
          message: 'Service is unavailable. Please try again later.',
          error: error
        }
      }
      reply(errorResponse).code(500)
    }
  })()
}
