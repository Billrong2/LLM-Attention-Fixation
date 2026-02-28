f <- function(n) {    b <- strsplit(as.character(n), '')[[1]]
    if (length(b) > 2) {
        b[3:length(b)] <- paste0(b[3:length(b)], '+')
    }
    return(b)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(44), c('4', '4'))))
}
test_humaneval()
