/* eslint-disable strict */

'use strict';

const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const AssetsPlugin = require('assets-webpack-plugin');
const paths = require('./paths');

const resolve = paths.resolve;

module.exports = {
  entry: {
    application: resolve(paths.JAVASCRIPT_PATH, 'application.js'),
    styles: resolve(paths.STYLESHEET_PATH, 'global.scss'),
  },
  output: {
    path: resolve('public/packaged-assets/assets'),
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: paths.JAVASCRIPT_PATH,
        loader: 'babel-loader',
      },
      {
        test: /\.scss$/,
        include: paths.STYLESHEET_PATH,
        enforce: 'pre',
        loader: 'import-glob-loader',
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            'css-loader',
            'postcss-loader',
            'sass-loader',
          ],
        }),
      },
    ],
  },
  plugins: [
    new AssetsPlugin({
      filename: 'webpack-manifest.json',
      path: resolve('tmp'),
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor',
      minChunks(module) {
        return module.context && module.context.indexOf('node_modules') !== -1;
      },
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'manifest',
    }),
    new webpack.ProvidePlugin({
      Promise: 'es6-promise-promise',
    }),
  ],
};
