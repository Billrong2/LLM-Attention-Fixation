f <- function(a, b) {
    a = paste(a, collapse = b)
    lst = list()
    for (i in seq(1, nchar(a), 2)) {
        lst = append(lst, list(substr(a, i, i+i-1)))
        lst = append(lst, list(substr(a, i+i, nchar(a))))
    }
    return(unlist(lst))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('a', 'b', 'c'), ' '), c('a', ' b c', 'b c', '', 'c', ''))))
}
test_humaneval()
