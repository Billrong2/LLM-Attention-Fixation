f <- function(d, index) {    length <- length(d)
    idx <- index %% length
    v <- tail(d, 1)[[1]]
    for (i in seq_len(idx)) {
        d <- d[-length(d)]
    }
    return(v)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("27" = 39), 1), 39)))
}
test_humaneval()
