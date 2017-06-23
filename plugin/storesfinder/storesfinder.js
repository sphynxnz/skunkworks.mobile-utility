/**
 * @function anonymous - this is the stores finder plugin
 * @param {Object} request - http request object
 * @param {Object} reply - http reply object
 */
module.exports = function (request, reply) {
  /**
   * Get reference to the hapijs server object which is available from the request object
   */
  let server = request.server

  /**
   * Initialise input parameters to findStores function
   */
  let args = request.query

  server.log('info', 'args: ' + JSON.stringify(args))

  /**
   * Invoke the target ticket checking function passing the hapijs server and input arguments.
   * The findStore function is synchonous. All work is done in memory.
   */
  try {
    let results = server.methods.findStores(args)
    reply(results).code(200)
  } catch (error) {
    /**
     * Errors will be caught here and a custom error response is returned
     */
    server.log('info', 'In catch of findStores api call')
    server.log('error', error.toString())
    let errorResponse = {
      status: 'failure',
      statusCode: 500,
      message: 'Service is unavailable. Please try again later.',
      error: error
    }
    reply(errorResponse).code(500)
  }
}
