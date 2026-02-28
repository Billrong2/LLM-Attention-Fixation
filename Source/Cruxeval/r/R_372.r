f <- function(list_, num) {    temp <- c()
    for (i in list_) {
        i <- paste(rep(i, num %/% 2), collapse = ',')
        temp <- c(temp, i)
    }
    return(temp)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('v'), 1), c(''))))
}
test_humaneval()
