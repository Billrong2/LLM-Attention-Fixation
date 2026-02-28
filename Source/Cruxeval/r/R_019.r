f <- function(x, y) {    tmp <- paste0(ifelse(strsplit(y, '')[[1]] == '9', '0', '9'), collapse = '')
    if (grepl('^[0-9]+$', x) && grepl('^[0-9]+$', tmp)) {
        return (paste0(x, tmp))
    } else {
        return (x)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('', 'sdasdnakjsda80'), '')))
}
test_humaneval()
