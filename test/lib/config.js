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
    ticketchecker: 'http://localhost:8000/api/util/v1',
    // ticketchecker_gcp: 'http://130.211.213.53/api/util/v1'
    ticketchecker_gcp: 'http://35.192.45.72/api/util/v1'
  }
}
