f <- function(strand, zmnc) {    poz <- regexpr(zmnc, strand)[1]
    while (poz != -1) {
        strand <- substr(strand, poz + 1, nchar(strand))
        poz <- regexpr(zmnc, strand)[1]
    }
    return(max(regexpr(zmnc, strand)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('', 'abc'), -1)))
}
test_humaneval()
