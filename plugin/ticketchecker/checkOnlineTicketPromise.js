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
         * Initialise response to online ticket checking
         */
        let checkResult = {
          validationResult: {},
          response: {
            status: 'success',
            message: 'System available'
          }
        }

        /**
         * Set amount to cash amount cash amount is defined and it is not a major prize
         * based on the data found in the matching scenario
         */
        if (data.cashAmount && result.majorprizemsg === undefined) {
          checkResult.validationResult.amount = parseFloat(data.cashAmount)
        }

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
         * <bonus tickets> = Math.ceil(<free tickets number> / <bonus lines per page>)
         *
         */
        if (data.freeTicketsNumber && parseInt(data.freeTicketsNumber) > 0) {
          let bonusTickets = parseInt(data.freeTicketsNumber)
          let productCode = args.ticketSerialNumber.substr(14, 2)
          let blpp = 1
          server.log('info', 'Product: ' + productCode)
          if (productCode === misc.products.Strike.code) {
            blpp = misc.bonusLinesPerPage.Strike
          } else if (productCode === misc.products.Bullseye.code) {
            blpp = misc.bonusLinesPerPage.Bullseye
          }
          server.log('info', 'lines: ' + blpp)
          checkResult.validationResult.bonusTickets = Math.ceil(bonusTickets / blpp)
        }

        /**
         * Assign currency, link text
         */
        checkResult.validationResult.currency = '$'
        checkResult.validationResult.linkText = misc.linkText

        /**
         * If response includes claim amount or matched scenario includes major prize,
         * then add major prize message in response. And if matched scenario contains
         * claim message, then replace message with claim message.
         */
        if ((data.claimAmount && parseFloat(data.claimAmount) >= 0) || result.majorprizemsg) {
          checkResult.validationResult.majorPrizeMessage = result.majorprizemsg
          if (result.claimmsg) {
            checkResult.validationResult.message = result.claimmsg
          }
        }

        /**
         * Assign result, code
         */
        checkResult.validationResult.resultCode = result.code
        checkResult.validationResult.resultType = result.result

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
