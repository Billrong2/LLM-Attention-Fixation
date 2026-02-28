function f($d) {
    $i = new ArrayIterator($d);
    return [$i->current(), $i->next()];
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a" => 123, "b" => 456, "c" => 789)) !== array(array("a", 123), array("b", 456))) { throw new Exception("Test failed!"); }
}

test();
