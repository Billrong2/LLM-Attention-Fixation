f <- function(text) {    a <- unlist(strsplit(trimws(text), ' '))
    for (i in 1:length(a)) {
        if (!grepl('^[0-9]+$', a[i])) {
            return('-')
        }
    }
    paste(a, collapse = ' ')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('d khqw whi fwi bbn 41'), '-')))
}
test_humaneval()
