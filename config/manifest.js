/**
 * @const argv
 * Package for handling CLI arguments
 */
const argv = require('yargs').argv

/**
 * @const utilEnv
 * Derived app environment in the following precedence: cli argument, process environment, default is 'mock'
 */
const utilEnv = (argv.env || process.env.NODE_ENV || 'mock').toLowerCase()

/**
 * @const envconfig
 * Uses system environment variable TCENV to select server configuration.
 * Currently, only specifies the endpoint to the ESI Soap Web Service.
 */
const envconfig = require('./envconfig-' + utilEnv + '.js')

/**
 * @const bunyan
 * Logging plugin for hapijs
 */
const bunyan = require('bunyan')

/**
 * Exports an object as a manifest used in the Glue function to build the server configuration.
 * This manifest object contains all application-specific configurations, server connections,
 * server routes and all custom (e.g. ticketchecker) and packaged (e.g. hapi-bunyan) plugins.
 */
module.exports = {
  server: {
    app: {
      env: envconfig
    }
  },
  connections: [
    {
      host: '0.0.0.0',
      port: envconfig.port,
      labels: ['API']
    },
    {
      routes: {
        timeout: {
          server: envconfig.timeout
        }
      }
    }
  ],
  registrations: [
    {
      plugin: {
        register: './ticketchecker',
        options: {
          getpath: envconfig.getCheckerPath,
          postpath: envconfig.postCheckerPath,
          heartbeatpath: envconfig.heartbeatPath,
          appname: envconfig.appName,
          version: envconfig.version
        },
        routes: {
          prefix: envconfig.basePath
        }
      }
    },
    {
      plugin: {
        register: './storesfinder',
        options: {
          getpath: envconfig.getStoresPath
        },
        routes: {
          prefix: envconfig.basePath
        }
      }
    },
    {
      plugin: {
        register: 'hapi-bunyan',
        options: {
          logger: bunyan.createLogger(envconfig.loggerConfig)
        }
      }
    },
    {
      plugin: {
        register: 'inert'
      }
    },
    {
      plugin: {
        register: 'vision'
      }
    },
    {
      plugin: {
        register: 'hapi-swagger',
        options: {
          info: {
            title: 'Mobile Utility API Documentation',
            version: '0.0.1'
          },
          basePath: envconfig.basePath,
          documentationPath: envconfig.basePath + '/docs'
        }
      }
    }
  ]
}
