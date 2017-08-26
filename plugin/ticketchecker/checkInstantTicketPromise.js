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
          validationResult: {
            amount: (data.amount !== undefined ? parseFloat(data.amount) : null),
            bonusTicket: (data.freeTicketsNumber !== undefined ? parseInt(data.freeTicketsNumber) : null),
            commMessage: (result.communitymsg !== undefined ? messages[Math.floor(Math.random() * messages.length)] : null),
            currency: misc.currency,
            linkText: misc.linkText,
            linkUrl: misc.linkUrl,
            majorPrizeMessage: result.majorprizemsg,
            // merchandise: null,
            message: result.mobile,
            // multiDrawMsg: null,
            resultCode: result.code,
            resultType: result.result
          },
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
        if (checkResult.validationResult.amount && checkResult.validationResult.amount > 0) {
          if (result.majorprizemsg) {
            delete checkResult.validationResult.amount
          }
          if (checkResult.validationResult.bonusTicket && checkResult.validationResult.bonusTicket > 0) {
            if (misc.IKFreeTicketAmountIgnored) {
              delete checkResult.validationResult.amount
            }
          }
        }

        /**
         * If code in matched scenario is 3242 and there are no free tickets, then use 1201 as the code
         * otherwise, retain the code value
         */
        if (result.code === '3242' && (data.freeTicketsNumber === undefined || parseInt(data.freeTicketsNumber) === 0)) {
          checkResult.validationResult.resultCode = '1201'
        }

        /**
         * Delete message, link url if emulating mule 2.0 mobile utility
         * If fault, delete currency and set bonus ticket to 0
         */
        if (server.settings.app.env.emulation) {
          delete checkResult.validationResult.message
          delete checkResult.validationResult.linkUrl
          if (fault) {
            delete checkResult.validationResult.currency
            checkResult.validationResult.bonusTicket = 0
          }
        }

        /**
         * Delete all null properties
         */
        Object.keys(checkResult.validationResult).forEach((prop) => {
          if (checkResult.validationResult[prop] === undefined || checkResult.validationResult[prop] === null) {
            delete checkResult.validationResult[prop]
          }
        })

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
