function f(container: any[], cron: any): any[] {
    if (container.indexOf(cron) === -1) {
        return container;
    }

    const pref = container.slice(0, container.indexOf(cron));
    const suff = container.slice(container.indexOf(cron) + 1);

    return pref.concat(suff);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([], 2),[]);
}

test();
