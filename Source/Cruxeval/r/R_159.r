f <- function(st) {    swapped <- ''
    for (ch in rev(strsplit(st, NULL)[[1]])) {
        swapped <- paste0(swapped, ifelse(ch == tolower(ch), toupper(ch), tolower(ch)))
    }
    return(swapped)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('RTiGM'), 'mgItr')))
}
test_humaneval()
