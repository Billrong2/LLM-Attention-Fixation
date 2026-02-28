function f(simpons: string[]): string {
    let pop: string;
    while (simpons.length > 0) {
        pop = simpons.pop()!;
        if (pop === pop.charAt(0).toUpperCase() + pop.slice(1)) {
            return pop;
        }
    }
    return pop!;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["George", "Michael", "George", "Costanza"]),"Costanza");
}

test();
