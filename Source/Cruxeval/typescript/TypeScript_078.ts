function f(text: string): string {
    if (text && text === text.toUpperCase()) {
        const cs = text.toUpperCase().split('').reduce((acc, curr, index) => {
            acc[curr.charCodeAt(0)] = text.toLowerCase()[index];
            return acc;
        }, {});
        return text.split('').map(char => cs[char.charCodeAt(0)] || char).join('');
    }
    return text.toLowerCase().substring(0, 3);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n"),"mty");
}

test();
