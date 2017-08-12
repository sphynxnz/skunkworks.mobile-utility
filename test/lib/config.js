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
    ticketchecker: 'http://localhost:8000/api/mobileutility/v1',
    ticketchecker_gcp: 'http://35.192.45.72/api/mobileutility/v1'
  },
  wsdl: {
    mule_mobutil: 'http://localhost:8081/MobileUtilityService/v1?wsdl'
  }
}
