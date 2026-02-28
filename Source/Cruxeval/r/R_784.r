f <- function(key, value) {
    dict_ <- setNames(as.list(value), key)
    popped <- dict_[length(dict_)]
    names <- names(popped)
    values <- as.character(popped)
    return(c(names, values))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('read', 'Is'), c('read', 'Is'))))
}
test_humaneval()
