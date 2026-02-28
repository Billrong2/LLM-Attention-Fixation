f <- function(postcode) {    substring(postcode, first = regexpr('C', postcode))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ED20 CW'), 'CW')))
}
test_humaneval()
