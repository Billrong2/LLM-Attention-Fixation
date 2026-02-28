f <- function(start, end, interval) {    steps <- seq(start, end, by = interval)
    if (1 %in% steps) {
        steps[length(steps)] <- end + 1
    }
    return(length(steps))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(3, 10, 1), 8)))
}
test_humaneval()
