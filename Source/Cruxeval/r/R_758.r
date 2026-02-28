f <- function(nums) {    if(identical(nums, rev(nums))) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 3, 6, 2)), FALSE)))
}
test_humaneval()
