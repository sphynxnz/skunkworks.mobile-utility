/**
 * @const _
 * JS library for working with arrays, numbers, objects, strings, etc
 */
const _ = require('lodash')

/**
 * @function checkOnlineTicketPromise - async function for checking IK tickets
 * @param {Object} pObj - JSON blob for passing around input and output parameters when using Promises/
 * @returns {Promise}
 */
const checkOnlineTicketPromise = (pObj) => {
  pObj.server.log('info', 'In OLP')

  return new Promise((resolve, reject) => {
    /**
     * Extract references for hapijs server and input parameters to online ticket checking
     */
    let server = pObj.server
    let args = pObj.args

    try {
      /**
       * Invoke checkOnlineTicket function to check online ticket
       */
      server.methods.checkOnlineTicket(args, (err, data, fault) => {
        /**
         * If error then return error. Any non-Lotto NZ SOAP fault will be returned as an error.
         */
        if (err != null) {
          server.log('info', 'OLP err')
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
         *  scenarios - result scenarios for online ticket based on whether the response is a Lotto NZ SOAP fault or not
         *  misc - miscellaneous data used for ticket checking
         *  messages - community messages
         */
        let scenarios = (fault ? server.app.resultScenarios.online.faultResults : server.app.resultScenarios.online.okResults)
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
         * Initialise response to Online ticket checking
         */
        let checkResult = {
          validationResult: {
            amount: (data.cashAmount !== undefined ? parseFloat(data.cashAmount) : null),
            bonusTicket: null,
            commMessage: (result.communitymsg !== undefined ? messages[Math.floor(Math.random() * messages.length)] : null),
            currency: misc.currency,
            linkText: misc.linkText,
            linkUrl: misc.linkUrl,
            majorPrizeMessage: null,
            // merchandise: null,
            message: result.mobile,
            multiDrawMsg: null,
            resultCode: result.code,
            resultType: result.result
          },
          response: {
            status: 'success',
            message: 'System available'
          }
        }

        /**
         * Process response depending on ESI response
         */
        if (fault) {
          /**
           * If ESI fault message, reset these properties
           */
          checkResult.validationResult.cashAmount = null
          checkResult.validationResult.bonusTicket = 0
          checkResult.validationResult.currency = null
          checkResult.validationResult.majorPrizeMessage = result.majorprizemsg
        } else {
          /**
           * Non-ESI fault message, process as follows
           */

          /**
           * If free tickets then calculate the number of bonus tickets.
           * The number of bonus tickets is determined by the type of the game (product code)
           * and is calculated based on the following formula:
           *
           * Given:
           *    bonus lines per page (Strike)       = 20
           *    bonus lines per page (Bullseye)     = 3
           *    bonus lines per page (other games)  = 1
           *
           * <bonus tickets> = Math.ceil(<free tickets number> / <bonus lines per page>) if (Strike or Bullseye)
           *                 = <bonus tickets> otherwise
           *
           * Note: Always calculate bonus ticket in emulation mode. If not, only when > 0
           */
          if (data.freeTicketsNumber !== undefined &&
            (server.settings.app.env.emulation || parseInt(data.freeTicketsNumber) > 0)) {
            let bonusTicket = parseInt(data.freeTicketsNumber)
            let productCode = parseInt(args.ticketSerialNumber.substr(14, 2))
            let blpp = 1
            server.log('info', 'Product: ' + productCode)
            if (productCode !== misc.products.Strike.code && productCode !== misc.products.Bullseye.code) {
              checkResult.validationResult.bonusTicket = bonusTicket
            } else {
              if (productCode === misc.products.Strike.code) {
                blpp = misc.bonusLinesPerPage.Strike
              } else if (productCode === misc.products.Bullseye.code) {
                blpp = misc.bonusLinesPerPage.Bullseye
              }
              server.log('info', 'lines: ' + blpp)
              checkResult.validationResult.bonusTicket = Math.ceil(bonusTicket / blpp)
            }
          }

          /**
           * If response includes claim amount or if ESI returned fault and there is a major prize message
           * on the matched result, then add major prize message in response. 
           * 
           * If matched scenario contains claim message, then replace message with claim message
           * if emulation is not on.
           */
          // if (data.claimAmount && parseFloat(data.claimAmount) >= 0) {
          if (data.claimAmount !== undefined && parseFloat(data.claimAmount) >= 0) {
            checkResult.validationResult.majorPrizeMessage = result.majorprizemsg
          }

          /**
           * Assign multi draw message for multi draw scenario
           */
          if (result.code === misc.multiDrawCode) {
            checkResult.validationResult.multiDrawMsg = result.mobile
          }
        }

        /**
         * Delete message, link url if emulating mule 2.0 mobile utility
         * If fault, delete currency and set bonus ticket to 0
         */
        if (server.settings.app.env.emulation) {
          delete checkResult.validationResult.message
          delete checkResult.validationResult.linkUrl
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

        server.log('info', 'Online ticket ' + args.ticketSerialNumber + ' checked')

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
 * Export checkOnlineTicketPromise
 */
module.exports = checkOnlineTicketPromise
