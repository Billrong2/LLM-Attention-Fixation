f <- function(d, count) {
    new_dict <- list()
    for (i in seq_len(count)) {
        new_dict <- c(new_dict, d)
    }
    return(new_dict)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'a'" = 2, "'b'" = c(), "'c'" = list()), 0), list())))
}
test_humaneval()
