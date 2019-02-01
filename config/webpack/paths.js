/* eslint-disable strict */

'use strict';

const path = require('path');
const _ = require('lodash');

const root = path.resolve(__dirname, '../..');
const resolve = _.partial(path.resolve, root);

exports.resolve = resolve;

exports.JAVASCRIPT_PATH = resolve('app/webpack/javascripts');
exports.STYLESHEET_PATH = resolve('app/webpack/stylesheets');
exports.WEBPACK_PATH = resolve('config/webpack');
