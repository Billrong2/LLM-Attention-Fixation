f <- function(numbers) {
    floats <- numbers %% 1
    if (1 %in% floats) {
        return(floats)
    } else {
        return(NULL)
    }
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119)), c())))
}
test_humaneval()
