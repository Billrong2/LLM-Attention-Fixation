f <- function(text, splitter) {    return(paste(tolower(strsplit(text, " ")[[1]]), collapse = splitter))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('LlTHH sAfLAPkPhtsWP', '#'), 'llthh#saflapkphtswp')))
}
test_humaneval()
