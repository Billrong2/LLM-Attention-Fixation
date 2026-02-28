f <- function(a) {
    a <- gsub('/', ':', a, fixed = TRUE)
    z <- strsplit(a, ':')[[1]]
    n <- length(z)
    if (n == 1) {
        z <- c('', '', z[1])
    } else if (n == 2) {
        z <- c(z[1], ':', z[2])
    } else if (n > 2) {
        z <- c(paste(z[-c(n, n-1)], collapse = ':'), ':', z[n-1])
    }
    return(z)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('/CL44     '), c('', ':', 'CL44     '))))
}
test_humaneval()
