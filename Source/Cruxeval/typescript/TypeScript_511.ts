function f(fields: [string, string, string], update_dict: {[key: string]: string}): {[key: string]: string} {
    let di: {[key: string]: string} = {};
    fields.forEach(field => {
        di[field] = '';
    });
    di = {...di, ...update_dict};
    return di;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["ct", "c", "ca"], {"ca": "cx"}),{"ct": "", "c": "", "ca": "cx"});
}

test();
