<?php
function f($s) {
    return strtoupper($s);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1") !== "JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1") { throw new Exception("Test failed!"); }
}

test();
