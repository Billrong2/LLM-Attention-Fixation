f <- function(ets) {    while(length(ets) > 0) {
        pair <- tail(ets, 1)
        ets <- head(ets, -1)
        k <- names(pair)
        v <- pair
        ets[k] <- v^2
    }
    return(ets)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
