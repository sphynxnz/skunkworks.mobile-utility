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
 * @function init - loads checkOnlineTicket function handle into the server.methods object for subsequent use
 * @param {Object} server - hapijs server object
 */
const init = (server) => {
  server.log('info', 'In OL init')

  /**
   * @function checkOnlineTicket - checks an online ticket
   * @param {Object} args - parameters that include serial number, channel id, etc.
   * @param {function} callback - callback as (err, result, faultflag)
   */
  const checkOnlineTicket = (args, callback) => {
    server.log('info', 'Args check OL:' + JSON.stringify(args))

    /**
     * Invokes ESI Soap WS operation to 'check/validate' an online ticket
     */
    server.app.esiSoapClient.validationInquiryOnlineCmd(args, function (err, result) {
      /** Return result if there is no error */
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
         * Test if Lotto NZ
         */
        if (err.body.indexOf('http://nzlotteries.co.nz/exception/v1') >= 0) {
          /**
           * If Lotto NZ SOAP fault, return as a non-error with flag indicating fault
           */
          return (callback(null, x2j, true))
        } else {
          /**
           * If not a Lotto NZ SOAP fault, return as an error with flag indicating fault
           */
          return (callback(x2j, null, true))
        }
      }

      /**
       * Anything else is returned as an error
       */
      return (callback(err, null, false))
    }, { timeout: server.settings.app.env.esiTimeout })
  }

  /**
   * Save handle to the checkOnlineTicket function in server.methods
   */
  server.method('checkOnlineTicket', checkOnlineTicket)
  server.log('info', 'checkOnlineTicket loaded')
}

/**
 * Export init function
 */
module.exports = {
  'init': init
}
