/**
 * @const fxp
 * Fast xml parser used to parse ESi Soap Faults
 */
const fxp = require('fast-xml-parser')

/**
 * @const trimjson
 * Trims the string values of all leaf nodes of a json object, getting rid of leading and trailing
 * spaces, including control characters such as \n, \t, \r.
 */
const trimjson = require('./trimjson')

/**
 * @function init - loads checkInstantTicket function handle into the server.methods object for subsequent use
 * @param {Object} server - hapijs server object
 */
const init = (server) => {
  server.log('info', 'In IK init')

  /**
   * @function checkInstantTicket - checks an IK ticket
   * @param {Object} args - parameters that include serial number, channel id, etc.
   * @param {function} callback - callback as (err, result, faultflag)
   */
  const checkInstantTicket = (args, callback) => {
    server.log('info', 'Args for check IK:' + JSON.stringify(args))

    /**
     * Invokes ESI Soap WS operation to 'check/validate' an IK ticket
     */
    server.app.esiSoapClient.validationInquiryInstantCmd(args, function (err, result) {
      /**
       * Return result if there is no error
       */
      if (!err) {
        server.log('info', result)
        return (callback(null, result, false))
      }

      /**
       * Test if the error is a SOAP Fault
       */
      if (err.body && err.body.indexOf('faultcode') >= 0) {
        /**
         * If SOAP Fault, convert to JSON and trim string values
        */
        server.log('info', JSON.stringify(err.body))
        let x2j = trimjson(fxp.parse(err.body, { ignoreNameSpace: true }))
        server.log('info', x2j)

        /**
         * Test if SOAP fault is custom Lotto NZ fault.
         * If Lotto NZ SOAP fault, then return as non-error with flag indicatin fault,
         * else return as an error with flag indicating fault
         */
        if (err.body.indexOf('http://nzlotteries.co.nz/exception/v1') >= 0) {
          return (callback(null, x2j, true))
        } else {
          return (callback(x2j, null, true))
        }
      }

      /**
       * Anything else is returned as an error
       */
      return (callback(err, null, false))
    }, { timeout: 5000 })
  }

  /**
   * Save reference to the checkInstantTicket function in server.methods
   */
  server.method('checkInstantTicket', checkInstantTicket)
  server.log('info', 'checkInstantTicket loaded')
}

/**
 * Export init function
 */
module.exports = {
  'init': init
}
