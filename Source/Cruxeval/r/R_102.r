f <- function(names, winners) {    ls <- lapply(names, function(name) {
        if (name %in% winners) {
            return(which(names == name))
        }
    })
    ls <- unlist(ls)
    ls <- sort(ls, decreasing = TRUE)
    return(ls)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('e', 'f', 'j', 'x', 'r', 'k'), c('a', 'v', '2', 'im', 'nb', 'vj', 'z')), c())))
}
test_humaneval()
