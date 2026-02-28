f <- function(text, suffix) {
    if (nchar(suffix) > 0 && substr(suffix, nchar(suffix), nchar(suffix)) %in% strsplit(text, '')[[1]]) {
        return(f(gsub(suffix, '', text, fixed = TRUE), substr(suffix, 1, nchar(suffix) - 1)))
    } else {
        return(text)
    }
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('rpyttc', 'cyt'), 'rpytt')))
}
test_humaneval()
