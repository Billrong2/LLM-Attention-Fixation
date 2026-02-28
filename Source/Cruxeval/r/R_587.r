f <- function(nums, fill) {
    ans <- as.list(setNames(rep(fill, length(unique(nums))), unique(nums)))
    return(ans)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 1, 1, 2), 'abcca'), list("0" = 'abcca', "1" = 'abcca', "2" = 'abcca'))))
}
test_humaneval()
