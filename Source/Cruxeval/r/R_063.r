f <- function(text, prefix) {    while (grepl(paste0("^", prefix), text)) {
        text <- substring(text, first = nchar(prefix) + 1)
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ndbtdabdahesyehu', 'n'), 'dbtdabdahesyehu')))
}
test_humaneval()
