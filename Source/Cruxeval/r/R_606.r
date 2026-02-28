f <- function(value) {    ls <- strsplit(value, '')[[1]]
    ls <- c(ls, 'NHIB')
    paste(ls, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ruam'), 'ruamNHIB')))
}
test_humaneval()
