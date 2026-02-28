f <- function(s, ch) {    sl <- s
    if (ch %in% strsplit(s, '')[[1]]) {
        sl <- gsub(sprintf('^%s+', ch), '', s)
        if (nchar(sl) == 0) {
            sl <- paste0(sl, '!?')
        }
    } else {
        return('no')
    }
    return(sl)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('@@@ff', '@'), 'ff')))
}
test_humaneval()
