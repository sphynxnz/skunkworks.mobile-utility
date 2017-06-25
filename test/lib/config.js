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
    ticketchecker_gcp: 'http://35.184.153.227:8000/api/util/v1'
  }
}
