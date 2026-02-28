f <- function(nums, pop1, pop2) {
    nums <- nums[-c(pop1, pop2+1)]
    print(nums)
    return(nums)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 5, 2, 3, 6), 2, 4), c(1, 2, 3))))
}
test_humaneval()
