f <- function(lst) {    sorted_lst <- sort(lst)
    sorted_lst[1:3]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(5, 8, 1, 3, 0)), c(0, 1, 3))))
}
test_humaneval()
