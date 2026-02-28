f <- function(nums) {    copy <- nums
    newDict <- list()
    for (k in names(copy)) {
        newDict[k] <- length(copy[[k]])
    }
    return(newDict)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
