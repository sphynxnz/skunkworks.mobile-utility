/**
 * @const haversine
 * Calculates the great-circle distance between two points on a sphere
 * given their longitudes and latitudes
 */
const haversine = require('haversine')

/**
 * @function init - loads findStores function handle into the server.methods object for subsequent use
 * @param {Object} server - hapijs server object
 */
const init = (server) => {
  server.log('info', 'In findStores init')

  /**
   * @function findStores - checks an online ticket
   * @param {Object} args - parameters that include serial number, channel id, etc.
   * @param {function} callback - callback as (err, result, faultflag)
   */
  const findStores = (args) => {
    server.log('info', 'Args findStores:' + JSON.stringify(args))

    /**
     * Calculates great-circle distances between reference point and location of each store.
     * The resulting objects are saved in an array in order to not mess with the original array
     * of stores data.
     */
    let storesOut = {
      stores: []
    }
    server.app.storesData.forEach((store) => {
      let s = Object.assign({}, store)
      let currentLocation = { longitude: args.longitude, latitude: args.latitude }
      let storeLocation = { longitude: s.longitude, latitude: s.latitude }
      s.distance = haversine(currentLocation, storeLocation)
      storesOut.stores.push(s)
    })

    /**
     * Sort the resulting array in increasing order of distances from the reference location
     */
    storesOut.stores.sort((a, b) => {
      return (a.distance - b.distance)
    })

    /**
     * Check if maxcount or radius is specified. If not, set maxcount to 20
     */
    if (!args.maxcount && !args.radius) {
      args.maxcount = 20
    }

    /**
     * Truncate if maxcount is specified
     */
    if (args.maxcount && args.maxcount > 0) {
      storesOut.stores = storesOut.stores.slice(0, args.maxcount)
      return (storesOut)
    }

    /**
     * Filter if radius is specified
     */
    if (args.radius && args.radius > 0) {
      storesOut.stores = storesOut.stores.filter((s) => { return s.distance <= args.radius })
      return (storesOut)
    }
  }

  /**
   * Save handle to the findStores function in server.methods
   */
  server.method('findStores', findStores)
  server.log('info', 'findStores loaded')
}

/**
 * Export init function
 */
module.exports = {
  'init': init
}
