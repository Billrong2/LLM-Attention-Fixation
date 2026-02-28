f <- function(nums) {  
    verdict <- function(x) x < 2
    res <- Filter(function(x) x != 0, nums)
    result <- lapply(res, function(x) list(x, verdict(x)))
    if (length(result) > 0) {
        return(result)
    }
    return('error - no numbers or all zeros!')
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 3, 0, 1)), list(list(3, FALSE), list(1, TRUE)))))
}
test_humaneval()
