const soap = require('soap')
const argv = require('yargs').argv

let mobclient = null

const validateSerialNumber = (args, callback) => {
  mobclient.validateSerialNumber(args, (err, result) => {
    if (!err) {
      return (callback(null, result))
    }
    return (callback(err, null))
  })
}

const validateSerialNumberPromise = (pObj) => {
  return new Promise((resolve, reject) => {
    try {
      let args = pObj.args
      validateSerialNumber(args, (err, data) => {
        if (err != null) {
          return (reject(err))
        }
        pObj.data = data
        return (resolve(pObj))
      })
    } catch (error) {
      return (reject(error))
    }
  })
}

function createSoapClient (url) {
  console.log('info', 'In create soap client...')
  return new Promise((resolve, reject) => {
    soap.createClient(url, (err, client) => {
      if (err) {
        return (reject(err))
      } else {
        return (resolve(client))
      }
    })
  })
}

(async () => {
  try {
    mobclient = await createSoapClient(argv.url || 'http://localhost:8081/MobileUtilityService/v1?wsdl')
    console.log(mobclient.describe())
    let pObj = {
      args: {
        serialNumber: '9891420700187937509924',
        checkDigits: '9924',
        channelId: 1
      }
    }
    let results = await validateSerialNumberPromise(pObj)
    console.log(JSON.stringify(results.data, null, 2))
  } catch (error) {
    console.log(error)
  }
})()
