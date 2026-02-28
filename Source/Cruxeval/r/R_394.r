f <- function(text) {    k <- strsplit(text, "\n")[[1]]
    i <- 0
    for (j in k) {
        if (nchar(j) == 0) {
            return(i)
        }
        i <- i + 1
    }
    return(-1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('2 m2 \n\nbike'), 1)))
}
test_humaneval()
