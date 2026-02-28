f <- function(lists) {    lists[[2]] <- append(lists[[2]], lists[[1]])
    return(lists[[1]])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(c(395, 666, 7, 4), c(), c(4223, 111))), c(395, 666, 7, 4))))
}
test_humaneval()
