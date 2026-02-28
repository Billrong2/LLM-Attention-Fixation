f <- function(text, sub) {    index <- c()
    starting <- 1
    while (starting != -1) {
        starting <- regexpr(sub, text, starting)
        if (starting != -1) {
            index <- c(index, starting)
            starting <- starting + nchar(sub)
        }
    }
    return(index)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('egmdartoa', 'good'), c())))
}
test_humaneval()
