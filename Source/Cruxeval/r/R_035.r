f <- function(pattern, items) {    result <- c()
    for(text in items) {
        pos <- max(gregexpr(pattern, text)[[1]])
        if (pos >= 0) {
            result <- c(result, pos)
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(' B ', c(' bBb ', ' BaB ', ' bB', ' bBbB ', ' bbb')), c())))
}
test_humaneval()
