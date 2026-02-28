f <- function(name) {    result <- c(substr(name, 1, 1), substr(substring(name, 2), 1, 1))
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('master. '), c('m', 'a'))))
}
test_humaneval()
