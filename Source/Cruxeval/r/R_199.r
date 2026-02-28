f <- function(s, char) {    base <- strrep(char, times = (lengths(gregexpr(char, s))[[1]]) + 1)
    return(sub(paste0(base, "$"), "", s))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mnmnj krupa...##!@#!@#$$@##', '@'), 'mnmnj krupa...##!@#!@#$$@##')))
}
test_humaneval()
