f <- function(test, sep, maxsplit) {    tryCatch({
        strsplit(test, sep, maxsplit)[[1]]
    }, error = function(e) {
        strsplit(test, ' ')[[1]]
    })
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ab cd', 'x', 2), c('ab cd'))))
}
test_humaneval()
