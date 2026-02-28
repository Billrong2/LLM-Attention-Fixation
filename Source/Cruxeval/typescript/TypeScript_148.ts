function f(forest: string, animal: string): string {
    const index: number = forest.indexOf(animal);
    const result: string[] = forest.split('');
    
    let i = index;
    while (i < forest.length - 1) {
        result[i] = forest[i + 1];
        i++;
    }
    
    if (i === forest.length - 1) {
        result[i] = '-';
    }
    
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("2imo 12 tfiqr.", "m"),"2io 12 tfiqr.-");
}

test();
