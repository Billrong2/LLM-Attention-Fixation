f <- function(text, substr, occ) {    n <- 0
    while (TRUE) {
        i <- max(gregexpr(substr, text, fixed = TRUE)[[1]])
        if (i == -1) {
            break
        } else if (n == occ) {
            return(i)
        } else {
            n <- n + 1
            text <- substr(text, 1, i - 1)
        }
    }
    return(-1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('zjegiymjc', 'j', 2), -1)))
}
test_humaneval()
