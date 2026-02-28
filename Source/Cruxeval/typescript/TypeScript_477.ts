function f(text: string): [string, string] {
    const parts: string[] = text.split('|');
    const problem: string = parts.pop() || '';
    const topic: string = parts.join('|');
    if (problem === 'r') {
        return [topic, topic.replace(/u/g, 'p')];
    }
    return [topic, problem];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("|xduaisf"),["", "xduaisf"]);
}

test();
