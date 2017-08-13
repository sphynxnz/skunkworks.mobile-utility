/**
 * Cloned from https://github.com/carbonrobot/relish.
 * Original version worked in cucumber@1.0.0, but not in latest version.
 * Updated to work in latest version cucumber@2.3.1
 */

'use strict'

const _ = require('lodash')
const http = require('request-promise')
const {defineSupportCode} = require('cucumber')

function CustomWorld () {
  const self = this

  /**
   * Sets latitude
   */
  this.setLatitude = function (latitude) {
    this.latitude = parseFloat(latitude)
  }

  /**
   * Sets longitude
   */
  this.setLongitude = function (longitude) {
    this.longitude = parseFloat(longitude)
  }

  /**
   * Sets radius
   */
  this.setRadius = function (radius) {
    this.radius = parseFloat(radius)
  }

  /**
   * Sets maxcount
   */
  this.setMaxcount = function (maxcount) {
    this.maxcount = parseInt(maxcount)
  }

  /**
   * Performs an HTTP GET request to the given uri
   */
  this.httpGet = function (uri) {
    return _httpRequest({ method: 'GET', uri: uri })
  }

  /**
   * Performs an HTTP DELETE request to the given uri
   */
  this.httpDelete = function (uri) {
    return _httpRequest({ method: 'DELETE', uri: uri })
  }

  /**
   * Performs an HTTP POST request to the given uri
   */
  this.httpPost = function (uri) {
    return _httpRequest({ method: 'POST', uri: uri })
  }

  /**
   * Gets the value of a property by its path
   */
  this.getValue = function (path) {
    return _.get(self.actualResponse, path)
  }

  /**
   * Return console formatted json for humanz
   */
  this.prettyPrintJSON = function (json) {
    return JSON.stringify(json, null, 2)
  }

  /**
   * Formats the assertion in a humanz readable way
   */
  this.prettyPrintError = function (actualValue, expectedValue) {
    return `\r\nExpected: ${expectedValue}\r\nActual: ${actualValue}\r\nRequest Body:\r\n${self.prettyPrintJSON(self.requestBody)}\r\nResponse Status Code: ${self.statusCode}\r\nResponse Body:\r\n${self.prettyPrintJSON(self.actualResponse)}`
  }

  /**
   * Internal http request generator
   */
  function _httpRequest (options) {
    if (self.baseUrl) {
      options.uri = self.baseUrl + options.uri
    }

    return http({
      method: options.method,
      uri: options.uri,
      body: self.requestBody,
      json: true,
      resolveWithFullResponse: true
    }).then(function (response) {
      if (process.env.DEBUG) {
        console.log(response)
      }

      self.actualResponse = response.body
      self.statusCode = response.statusCode
    }, function (response) {
      if (process.env.DEBUG) {
        console.log(response)
      }

      // parse the message for a json body
      // the message has the following format
      // XXX - { ...json... }
      console.log(response)
      const bodyString = response.message.slice(6)
      const body = JSON.parse(bodyString)

      self.actualResponse = body
      self.statusCode = response.statusCode
    })
  }
}

defineSupportCode(function ({setWorldConstructor}) {
  setWorldConstructor(CustomWorld)
})
