/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const secureDataShare = require('./lib/secure_data_share');

module.exports.secureDataShare = secureDataShare;
module.exports.contracts = [secureDataShare];
