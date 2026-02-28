f <- function(nums, spot, idx) {    insert <- nums
    insert <- append(insert, idx, after = spot)
    return(insert)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 0, 1, 1), 0, 9), c(9, 1, 0, 1, 1))))
}
test_humaneval()
