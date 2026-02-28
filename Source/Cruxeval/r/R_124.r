f <- function(txt, sep, sep_count) {    o <- ''
    while (sep_count > 0 && grepl(sep, txt)) {
        o <- paste0(o, substr(txt, 1, regexpr(sep, txt) - 1), sep)
        txt <- substr(txt, regexpr(sep, txt) + nchar(sep), nchar(txt))
        sep_count <- sep_count - 1
    }
    return(paste0(o, txt))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('i like you', ' ', -1), 'i like you')))
}
test_humaneval()
