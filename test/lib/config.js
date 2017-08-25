/**
 * Cloned from https://github.com/carbonrobot/relish
 */

'use strict'

/**
 * Configuration for the target service URL. The url is
 * concatenated to the tag @baseUrl defined in the feature.
 * The tag configuratione is set to @baseUrl-ticketchecker
 */
module.exports = {
  baseUrl: {
    mobileutility: 'http://localhost:8000/api/mobileutility/v1',
    mobileutility_soapmock: 'http://localhost:8888/api/mobileutility/v1',
    mobileutility_localmock: 'http://localhost:8000/api/mobileutility/v1',
    mobileutility_nodejsmock: 'http://localhost:8000/api/mobileutility/v1',
    mobileutility_cat2mock: 'http://192.168.102.196/api/mobileutility/v1',
    mobileutility_gcp: 'http://35.192.45.72/api/mobileutility/v1'
  }
}
