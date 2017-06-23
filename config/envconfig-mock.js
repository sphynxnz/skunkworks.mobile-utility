module.exports = {
  id: 'MOCK',
  appName: 'mobile-utility',
  version: '0.0.1',
  esiWsUrl: 'http://localhost:7777/esiwebservice?wsdl',
  basePath: '/api/util/v1',
  getCheckerPath: '/tickets/{serialnumber}',
  postCheckerPath: '/tickets',
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
  port: 8000,
  timeout: 5000
}
