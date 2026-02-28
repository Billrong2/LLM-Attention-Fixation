f <- function(s) {    if (nzchar(gsub("[^[:alpha:]]", "", s))) {
        return("yes")
    }
    if (s == "") {
        return("str is empty")
    }
    return("no")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Boolean'), 'yes')))
}
test_humaneval()
