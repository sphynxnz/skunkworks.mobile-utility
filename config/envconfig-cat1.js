module.exports = {
  id: 'LOCAL',
  appName: 'mobileutility',
  version: '0.0.1',
  esiWsUrl: 'http://192.168.100.202/nzl-ws/services/PlayerService/v1?wsdl',
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
