/* eslint-disable strict */

'use strict';

const merge = require('webpack-merge');
const StyleLintPlugin = require('stylelint-webpack-plugin');
const WebpackNotifierPlugin = require('webpack-notifier');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const paths = require('./paths');

module.exports = merge(require('./webpack.config'), {
  devtool: 'eval-source-map',
  output: {
    filename: '[name].js',
    chunkFilename: '[name].js',
  },
  module: {
    rules: [
      {
        enforce: 'pre',
        test: /\.jsx?$/,
        include: paths.JAVASCRIPT_PATH,
        loader: 'eslint-loader',
      },
    ],
  },
  plugins: [
    new ExtractTextPlugin('styles.css'),
    new StyleLintPlugin({
      configFile: './.stylelintrc.json',
      context: paths.STYLESHEET_PATH,
      syntax: 'scss',
      quiet: true,
    }),
    new WebpackNotifierPlugin({ alwaysNotify: true }),
  ],
});
