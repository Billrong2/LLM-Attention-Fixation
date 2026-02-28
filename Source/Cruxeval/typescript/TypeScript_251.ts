function f(messages: string[][]): string {
    const phone_code = "+353";
    let result: string[] = [];
    for (let message of messages) {
        message.push(...phone_code.split(""));
        result.push(message.join(";"));
    }
    return result.join(". ");
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([["Marie", "Nelson", "Oscar"]]),"Marie;Nelson;Oscar;+;3;5;3");
}

test();
