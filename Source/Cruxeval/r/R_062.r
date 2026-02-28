f <- function(user) {    keys <- names(user)
    values <- as.vector(unlist(user))
    if (length(keys) > length(values)) {
        return(keys)
    } else {
        return(values)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'eating'" = 'ja', "'books'" = 'nee', "'piano'" = 'coke', "'excitement'" = 'zoo')), c('ja', 'nee', 'coke', 'zoo'))))
}
test_humaneval()
