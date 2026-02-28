function f(varStr: string): string {
    if (isFinite(Number(varStr))) {
        return "int";
    } else if (isFinite(Number(varStr.replace('.', '')))) {
        return "float";
    } else if (varStr.trim().split(' ').length === 1 && varStr.length > 1) {
        return "str";
    } else if (varStr.length === 1) {
        return "char";
    } else {
        return "tuple";
    }
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(" 99 777"),"tuple");
}

test();
