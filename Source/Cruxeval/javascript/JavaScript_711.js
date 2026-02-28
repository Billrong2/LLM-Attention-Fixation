function f(text){
    return text.replace(/\n/g, '\t');
}

const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(`apples
	
pears
	
bananas`),`apples			pears			bananas`);
}

test();
