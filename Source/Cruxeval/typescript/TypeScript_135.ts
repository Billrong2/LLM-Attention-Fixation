function f(): string[] {
    const d: { [key: string]: [string, string][] } = {
        'Russia': [['Moscow', 'Russia'], ['Vladivostok', 'Russia']],
        'Kazakhstan': [['Astana', 'Kazakhstan']],
    };
    return Object.keys(d);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(),["Russia", "Kazakhstan"]);
}

test();
