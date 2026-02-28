function f(cities, name){
    if (!name){
        return cities;
    }
    if (name && name !== 'cities'){
        return [];
    }
    return cities.map(city => name + city);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["Sydney", "Hong Kong", "Melbourne", "Sao Paolo", "Istanbul", "Boston"], "Somewhere "),[]);
}

test();
