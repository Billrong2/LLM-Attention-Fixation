f <- function(text, fill, size) {    if (size < 0) {
        size <- abs(size)
    }
    if (nchar(text) > size) {
        return(substr(text, nchar(text) - size + 1, nchar(text)))
    } else {
        return(paste(rep(fill, size - nchar(text)), collapse = "") %&gt;% paste0(text))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('no asw', 'j', 1), 'w')))
}
test_humaneval()
