f <- function(items) {    result <- list()
    for (i in seq_along(items)) {
        d <- as.list(items)
        d <- d[-i]
        result <- c(result, list(d))
        items <- d
    }
    result
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(list(1, 'pos'))), list(list()))))
}
test_humaneval()
