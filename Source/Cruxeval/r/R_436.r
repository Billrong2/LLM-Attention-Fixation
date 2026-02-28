f <- function(s, characters) {
    unlist(strsplit(s, ''))[characters + 1]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('s7 6s 1ss', c(1, 3, 6, 1, 2)), c('7', '6', '1', '7', ' '))))
}
test_humaneval()
