f <- function(nums) {    counts <- 0
    for (i in nums) {
        if (grepl("^\\d+$", as.character(i))) {
            if (counts == 0) {
                counts <- counts + 1
            }
        }
    }
    return(counts)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 6, 2, -1, -2)), 1)))
}
test_humaneval()
