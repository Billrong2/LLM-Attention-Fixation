f <- function(x) {    a <- 0
    words <- unlist(strsplit(x, ' '))
    for (i in words) {
        a <- a + nchar(formatC(i, width = nchar(i)*2, flag = "0"))
    }
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('999893767522480'), 30)))
}
test_humaneval()
