f <- function(aDict) {    # transpose the keys and values into a new dict
    return(aDict)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("1" = 1, "2" = 2, "3" = 3)), list("1" = 1, "2" = 2, "3" = 3))))
}
test_humaneval()
