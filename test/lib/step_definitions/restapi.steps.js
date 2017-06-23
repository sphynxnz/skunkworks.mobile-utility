/**
 * Cloned from https://github.com/carbonrobot/relish.
 * Original version worked in cucumber@1.0.0, but not in latest version.
 * Updated to work in latest version cucumber@2.3.1
 */

'use strict'

const {defineSupportCode} = require('cucumber')
const _ = require('lodash')
const assert = require('assert')
const moment = require('moment')
const randomWords = require('random-words')

defineSupportCode(function ({Given, When, Then}) {
  Given(/^The json request data$/i, function (data) {
    this.requestBody = JSON.parse(data)
  })

  Given(/^The request data$/i, function (data) {
    const dataRows = data.hashes()
    const firstRow = dataRows[0]
    this.requestBody = firstRow
  })

  Given(/^The property "(.*)" is todays date$/i, function (path) {
    this.requestBody = this.requestBody || {}
    const ts = moment().format('MM-DD-YYYY')
    _.set(this.requestBody, path, ts)
  })

  Given(/^The property "(.*)" is a random word$/i, function (path) {
    this.requestBody = this.requestBody || {}
    const value = randomWords()
    _.set(this.requestBody, path, value)
  })

  Given(/^The property "(.*)" is "(.*)" random words$/i, function (path, nbr) {
    this.requestBody = this.requestBody || {}
    const value = randomWords({ exactly: parseInt(nbr), join: ' ' })
    _.set(this.requestBody, path, value)
  })

  Given(/^The property "(.*)" is todays date with format "(.*)"$/i, function (path, format) {
    this.requestBody = this.requestBody || {}
    const ts = moment().format(format)
    _.set(this.requestBody, path, ts)
  })

  Given(/^The property "(.*)" is a date "(\d*)" days in the future$/i, function (path, days) {
    this.requestBody = this.requestBody || {}
    const ts = moment().add(days, 'day').format('MM-DD-YYYY')
    _.set(this.requestBody, path, ts)
  })

  Given(/^The property "(.*)" is a date "(\d*)" days in the past$/i, function (path, days) {
    this.requestBody = this.requestBody || {}
    const ts = moment().subtract(days, 'day').format('MM-DD-YYYY')
    _.set(this.requestBody, path, ts)
  })

  Given(/^the property "(.*)" is set to "(.*)"$/i, function (path, value) {
    this.requestBody = this.requestBody || {}
    _.set(this.requestBody, path, value)
  })

  Given(/^the property "(.*)" is set to the response property "(.*)"$/i, function (path, oldPath) {
    this.requestBody = this.requestBody || {}
    _.set(this.requestBody, path, _.get(this.actualResponse, oldPath))
  })

  When(/^I make a GET request to "(.*)"$/i, function (uri) {
    return this.httpGet(uri)
  })

  When(/^I make a DELETE request to "(.*)"$/i, function (uri) {
    return this.httpDelete(uri)
  })

  When(/^I make a POST request to "(.*)"$/i, function (uri) {
    return this.httpPost(uri)
  })

  Then(/^The response should be "(.*)"$/i, function (expectedResponse, callback) {
    assert.equal(this.actualResponse, expectedResponse, `\r\nExpected: ${expectedResponse}\r\nActual: ${this.actualResponse}`)
    callback()
  })

  Then(/^The response property "(.*)" should be "(.*)"$/i, function (path, expectedValue, callback) {
    const actualValue = this.getValue(path)
    assert.equal(actualValue, expectedValue, this.prettyPrintError(actualValue, expectedValue))
    callback()
  })

  Then(/^The response property "([^"]*)" should be (\d+)$/, function (path, expectedValue, callback) {
    // Write code here that turns the phrase above into concrete actions
    const actualValue = this.getValue(path)
    assert.equal(actualValue, expectedValue, this.prettyPrintError(actualValue, expectedValue))
    callback()
  })

  Then(/^The response status code should be "(.*)"$/i, function (expectedValue, callback) {
    assert.equal(this.statusCode, expectedValue, this.prettyPrintError(this.statusCode, expectedValue))
    callback()
  })
})
