/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const shim = require('fabric-shim');
const util = require('util');

let banji = class {
    async Init(stub) {
        return stub.putState('dummyKey', Buffer.from('dummyValue'))
            .then(() => {
                console.info('Chaincode instantiation is successful');
                return shim.success();
            }, () => {
                return shim.error();
            });
    }

    async Invoke(stub) {
        console.info('Transaction ID: ' + stub.getTxID());
        console.info(util.format('Args: %j', stub.getArgs()));

        let ret = stub.getFunctionAndParameters();
        console.info(ret);

        let method = this[ret.fcn];
        if (!method) {
            console.log('no function of name:' + ret.fcn + ' found');
            throw new Error('Received unknown function ' + ret.fcn + ' invocation');
        }
        try {
            console.info('Calling function: ' + ret.fcn);
            let payload = await method(stub, ret.params, this);
            return shim.success(payload);
        } catch (err) {
            console.log(err);
            return shim.error(err);
        }
    }

    async saveFileInfo(stub, args) {

        let uniqueID = args[0];
        let Transaction = {
            password: args[1],
            filedetails: args[2],
            description: args[3],
            hash: args[4]
        };

        return stub.putState(uniqueID, Buffer.from(JSON.stringify(Transaction)))
            .then(() => {
                console.info('Chaincode instantiation is successful');
            }, () => {
                throw new Error('Error while commiting record into ledger');
            });
    }
};

shim.start(new banji());
