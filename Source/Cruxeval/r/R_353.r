f <- function(x) {    if (length(x) == 0) {
        return(-1)
    } else {
        cache <- list()
        for (item in x) {
            if (item %in% names(cache)) {
                cache[[as.character(item)]] <- cache[[as.character(item)]] + 1
            } else {
                cache[[as.character(item)]] <- 1
            }
        }
        return(max(unlist(cache)))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 0, 2, 2, 0, 0, 0, 1)), 4)))
}
test_humaneval()
