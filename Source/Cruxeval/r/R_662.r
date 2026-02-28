f <- function(values) {    names <- c('Pete', 'Linda', 'Angela')
    names <- c(names, values)
    names <- sort(names)
    return(names)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('Dan', 'Joe', 'Dusty')), c('Angela', 'Dan', 'Dusty', 'Joe', 'Linda', 'Pete'))))
}
test_humaneval()
