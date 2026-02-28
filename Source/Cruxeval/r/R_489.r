f <- function(text, value) {    sub(value, "", tolower(text), fixed = TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('coscifysu', 'cos'), 'cifysu')))
}
test_humaneval()
