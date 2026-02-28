f <- function(num, l) {    t <- ""
    while (l > nchar(num)) {
        t <- paste0(t, '0')
        l <- l - 1
    }
    return(paste0(t, num))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('1', 3), '001')))
}
test_humaneval()
