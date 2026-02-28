f <- function(list1, list2) {    l <- list1
    while (length(l) > 0) {
        if (tail(l, 1) %in% list2) {
            l <- head(l, -1)
        } else {
            return(tail(l, 1))
        }
    }
    return('missing')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 4, 5, 6), c(13, 23, -5, 0)), 6)))
}
test_humaneval()
