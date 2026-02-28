f <- function(a) {    if (a == 0) {
        return(0)
    }
    result <- c()
    while (a > 0) {
        result <- c(result, a %% 10)
        a <- a %/% 10
    }
    result <- rev(result)
    return(as.numeric(paste(result, collapse = "")))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(0), c(0))))
}
test_humaneval()
