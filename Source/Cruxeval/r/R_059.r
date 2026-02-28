f <- function(s) {    a <- strsplit(s, '')[[1]]
    b <- a
    for (i in length(a):1) {
        if (a[i] == ' ') {
            b <- b[-length(b)]
        } else {
            break
        }
    }
    paste(b, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hi '), 'hi')))
}
test_humaneval()
