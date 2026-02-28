f <- function(nums, val) {    new_list <- unlist(lapply(nums, function(i) rep(i, val)))
    sum(new_list)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(10, 4), 3), 42)))
}
test_humaneval()
