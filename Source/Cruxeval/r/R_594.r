f <- function(file) {    return(gregexpr("\n", file)[[1]][1] - 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('n wez szize lnson tilebi it 504n.\n'), 33)))
}
test_humaneval()
