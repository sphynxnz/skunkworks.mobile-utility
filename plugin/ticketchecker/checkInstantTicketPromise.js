/**
 * @const _
 * JS library for working with arrays, numbers, objects, strings, etc
 */
const _ = require('lodash')

/**
 * @function checkInstantTicketPromise - async function for checking IK tickets
 * @param {Object} pObj - JSON blob for passing around input and output parameters when using Promises/
 * @returns {Promise}
 */
const checkInstantTicketPromise = (pObj) => {
  pObj.server.log('info', 'In IKP')

  return new Promise((resolve, reject) => {
    /**
     * Extract references for hapijs server and input parameters to IK ticket checking
     */
    let server = pObj.server
    let args = pObj.args
    try {
      /**
       * Invoke checkInstantTicket function to check IK ticket
       */
      server.methods.checkInstantTicket(args, (err, data, fault) => {
        /**
         * If error then return error. Any non-Lotto NZ SOAP fault will be returned as an error.
         */
        if (err != null) {
          return (reject(err))
        }

        /**
         * Save returned data in the pObj for future reference if needed
         */
        pObj.rawCheckResult = data

        /**
         * If fault is true, then the response is a Lotto NZ SOAP fault.
         * If fault, then set ESI message to exceptionMessage of the Lotto NZ SOAP fault,
         * else set ESI message to the resultText of the response body.
         */
        let esimsg = (fault ? data.Envelope.Body.Fault.detail.faultInfo.exceptionMessage : data.resultText)

        /**
         * Get references to the following:
         *  scenarios - result scenarios for IK tickets
         *  misc - miscellaneous data used for ticket checking
         *  messages - community messages
         */
        let scenarios = server.app.resultScenarios.instant.results
        let misc = server.app.misc
        let messages = server.app.communityMessages.messages

        /**
         * Find match for the ESI message in the result scenarios
         */
        let idx = _.findIndex(scenarios, (node) => {
          return (node.esi === esimsg)
        })

        /**
         * If no match was found, use the missing scenario from the miscellaneous data
         */
        let result = (idx >= 0 ? scenarios[idx] : misc.missing)
        server.log('info', 'Scenario: ' + result.name + ' Code: ' + result.code)

        /**
         * Initialise response to IK ticket checking
         */
        let checkResult = {
          validationResult: {},
          response: {
            status: 'success',
            message: 'System available'
          }
        }

        /**
         * Check if amount will be included in response. It will be included if:
         * - amount is present in the response from ESI and
         * - major prize is not defined in the matching scenario and
         * - there are no free tickets or free ticket is present in the response from ESI but
         *   has value of 0 or must be ignored (IKFreeTicketAmountIgnored == false)
         */
        if ((data.amount && parseFloat(data.amount) > 0) && result.majorprizemsg === undefined &&
           (data.freeTicketsNumber === undefined ||
            (data.freeTicketsNumber && (parseInt(data.freeTicketsNumber) === 0 || misc.IKFreeTicketAmountIgnored === false)))) {
          checkResult.validationResult.amount = parseFloat(data.amount)
        }

        /**
         * Add free tickets in the response if found in the response from ESI
         */
        if (data.freeTicketsNumber) {
          checkResult.validationResult.bonusTickets = parseFloat(data.freeTicketsNumber)
        }

        /**
         * Assign default currency and link text
         */
        checkResult.validationResult.currency = '$'
        checkResult.validationResult.linkText = misc.linkText

        /**
         * If matched scenario includes major prize, then include major prize message in response.
         * And if matched scenario contains claim message, then replace message with claim message.
         */
        if (result.majorprizemsg) {
          checkResult.validationResult.majorPrizeMessage = result.majorprizemsg
          if (result.claimmsg) {
            checkResult.validationResult.message = result.claimmsg
          }
        }

        /**
         * Assign result type from the matched scenario. value is 'WINNER', 'LOSER' or 'OTHER'
         */
        checkResult.validationResult.resultType = result.result

        /**
         * If code in matched scenario is 3242 and there are no free tickets, then use 1201 as the code
         * otherwise, retain the code value
         */
        if (result.code === '3242' && (data.freeTicketsNumber === undefined || parseInt(data.freeTicketsNumber) === 0)) {
          checkResult.validationResult.resultCode = '1201'
        } else {
          checkResult.validationResult.resultCode = result.code
        }

        /**
         * If not emulating mule, add the following properties
         */
        server.log('emulation:', server.settings.app.env.emulation)
        if (!server.settings.app.env.emulation) {
          checkResult.validationResult.message = result.mobile
          checkResult.validationResult.linkUrl = misc.linkUrl
        }

        /**
         * If matched scenario requires a community message, randomly select one of the community messages
         */
        if (result.communitymsg === true) {
          let ridx = Math.floor(Math.random() * (8))
          checkResult.validationResult.commMessage = messages[ridx]
        }

        /**
         * Return ticket check result in the pObj
         */
        pObj.checkResult = checkResult

        server.log('info', 'IK ticket ' + args.ticketSerialNumber + ' checked')
        return (resolve(pObj))
      })
    } catch (error) {
      /**
       * Return error
       */
      return (reject(error))
    }
  })
}

/**
 * Export checkInstantTicketPromise
 */
module.exports = checkInstantTicketPromise
