f <- function(items) {    result <- c()
    for (item in items) {
        for (d in unlist(strsplit(item, ""))) {
            if (!grepl("[0-9]", d)) {
                result <- c(result, d)
            }
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('123', 'cat', 'd dee')), c('c', 'a', 't', 'd', ' ', 'd', 'e', 'e'))))
}
test_humaneval()
