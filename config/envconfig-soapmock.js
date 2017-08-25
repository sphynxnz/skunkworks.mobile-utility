module.exports = {
  id: 'MOCK',
  appName: 'mobile-utility',
  version: '0.0.1',
  esiWsUrl: 'http://localhost:8088/esiwebservice?wsdl',
  basePath: '/api/mobileutility/v1',
  getCheckerPath: '/validations/{serialnumber}',
  postCheckerPath: '/validations',
  getStoresPath: '/stores',
  heartbeatPath: '/heartbeat',
  loggerConfig: {
    name: 'mobileutility',
    level: 'debug',
    src: true,
    streams: [
      {
        stream: process.stdout
      },
      {
        type: 'file',
        path: './logs/mobileutility.log',
        period: '1d'
      }
    ]
  },
  port: 8888,
  timeout: 5000,
  esiTimeout: 5000,
  emulation: true
}
