f <- function(text) {    words <- unlist(strsplit(text, " "))
    for (word in words) {
        if (!grepl("^\\d+$", word)) {
            return('no')
        }
    }
    return('yes')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('03625163633 d'), 'no')))
}
test_humaneval()
