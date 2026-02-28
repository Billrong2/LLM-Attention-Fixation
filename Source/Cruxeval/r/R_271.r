f <- function(text, c) {    ls <- strsplit(text, '')[[1]]
    if (!grepl(c, text)) {
        stop(paste('Text has no', c))
    }
    ls <- ls[-tail(grep(c, ls), 1)]
    paste(ls, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('uufhl', 'l'), 'uufh')))
}
test_humaneval()
