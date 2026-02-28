f <- function(text, value) {    indexes <- c()
    for (i in 1:nchar(text)) {
        if (substring(text, i, i) == value && (i == 1 || substring(text, i-1, i-1) != value)) {
            indexes <- c(indexes, i)
        }
    }
    if (length(indexes) %% 2 == 1) {
        return(text)
    }
    return(substring(text, indexes[1]+1, indexes[length(indexes)]-1))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('btrburger', 'b'), 'tr')))
}
test_humaneval()
