/* eslint-disable strict */

'use strict';

const merge = require('webpack-merge');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = merge(require('./webpack.config'), {
  output: {
    filename: '[name].[chunkhash].js',
    chunkFilename: '[name].[chunkhash].js',
  },
  plugins: [
    new ExtractTextPlugin('styles.[contenthash].css'),
  ],
});
