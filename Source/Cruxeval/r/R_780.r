f <- function(ints) {    counts <- rep(0, 301)
    
    for (i in ints) {
        counts[i + 1] <- counts[i + 1] + 1
    }
    
    r <- c()
    for (i in 1:length(counts)) {
        if (counts[i] >= 3) {
            r <- c(r, toString(i - 1))
        }
    }
    counts <- NULL
    paste(r, collapse = " ")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 3, 5, 2, 4, 5, 2, 89)), '2')))
}
test_humaneval()
