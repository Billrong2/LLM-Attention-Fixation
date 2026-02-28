f <- function(s) {    toupper(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1'), 'JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1')))
}
test_humaneval()
