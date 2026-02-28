<?php
function f($container, $cron) {
    if (!in_array($cron, $container)) {
        return $container;
    }
    $pref = array_slice($container, 0, array_search($cron, $container));
    $suff = array_slice($container, array_search($cron, $container) + 1);
    return array_merge($pref, $suff);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), 2) !== array()) { throw new Exception("Test failed!"); }
}

test();
