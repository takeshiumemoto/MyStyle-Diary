const { environment } = require('@rails/webpacker')
process.env.NODE_OPTIONS = '--openssl-legacy-provider';
module.exports = environment
