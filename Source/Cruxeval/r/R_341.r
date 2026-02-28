f <- function(cart) {    while(length(cart) > 5) {
        cart <- head(cart, n = length(cart) - 1)
    }
    return(cart)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
