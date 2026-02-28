f <- function(string) {    l <- strsplit(string, '')[[1]]
    for (i in rev(seq_along(l))) {
        if (l[i] != ' ') {
            break
        }
        l <- l[-i]
    }
    paste(l, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('    jcmfxv     '), '    jcmfxv')))
}
test_humaneval()
