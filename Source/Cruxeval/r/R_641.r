f <- function(number) {    return(is.numeric(number))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dummy33;d'), FALSE)))
}
test_humaneval()
