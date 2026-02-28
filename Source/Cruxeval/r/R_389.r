f <- function(total, arg) {
    if (is.list(arg)) {
        for (e in arg) {
            total <- c(total, unlist(strsplit(e, split = '')))
        }
    } else {
        total <- c(total, unlist(strsplit(arg, split = '')))
    }
    return(total)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('1', '2', '3'), 'nammo'), c('1', '2', '3', 'n', 'a', 'm', 'm', 'o'))))
}
test_humaneval()
