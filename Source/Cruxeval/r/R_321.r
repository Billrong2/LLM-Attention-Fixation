f <- function(update, starting) {    d <- starting
    for (k in names(update)) {
        if (k %in% names(d)) {
            d[k] <- d[k] + update[k]
        } else {
            d[k] <- update[k]
        }
    }
    return(d)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(), list("'desciduous'" = 2)), list("'desciduous'" = 2))))
}
test_humaneval()
