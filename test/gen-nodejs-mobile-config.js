const args = require('yargs').argv
const fs = require('fs')

/**
 * Set input file name of mobile configuration in JSON format. 
 * This file is generated from the mobile-config.xml by issuing the following command:
 * 
 *  xml2js -ns mobile-config.xml -o mobile-config.json
 * 
 * The npm package is fast-xml-parser installed with -g option
 */
let mobileConfigFileName = args.in || './mobile-config-CAT1.json'

/**
 * Set the outpuf file name the fits the schema of the resultscenios.json file
 * used in the nodejs service implementation of the mobile utility service.
 */
let mobileConfigOutFileName = args.out || './mobile-resultscenarios.json'

/**
 * Load the mobile config file as JSON object
 */
let mobileConfigJson = JSON.parse(fs.readFileSync(mobileConfigFileName, 'utf-8'))

/**
 * Create the resultscenarios.json template to be used by the nodejs mobile utility service
 * implementation.
 */
let nodeMobileConfig = {
  instant: {},
  online: {}
}

/**
 * Extract the instant result scenarios
 */
nodeMobileConfig.instant.results = mobileConfigJson.configuration.mobile.service.validateserialnumber.ikscenarios.IK_SCENARIO

/**
 * Extract the online fault scenarios
 */
nodeMobileConfig.online.faultResults = mobileConfigJson.configuration.mobile.service.validateserialnumber.faultscenarios.FAULT_SCENARIO

/**
 * Extract the online OK scenarios
 */
nodeMobileConfig.online.okResults = mobileConfigJson.configuration.mobile.service.validateserialnumber.okscenarios.OK_SCENARIO

/**
 * Convert the JSON to string with 2-space indentation
 */
let nodeMobileConfigString = JSON.stringify(nodeMobileConfig, null, 2)

/**
 * Replace all 'COMMA' string instances with ','
 */
nodeMobileConfigString = nodeMobileConfigString.replace(/COMMA/g,',')

/**
 * Surround all numeric 'code' with quotes (")
 */
nodeMobileConfigString = nodeMobileConfigString.replace(/code": ([0-9]+)/g,'code": "$1"')

/**
 * Remove qoutes from communitymsg
 */
nodeMobileConfigString = nodeMobileConfigString.replace(/communitymsg": "true"/g,'communitymsg": true')

/**
 * Generate the output file
 */
fs.writeFileSync(mobileConfigOutFileName, nodeMobileConfigString, 'utf-8')
