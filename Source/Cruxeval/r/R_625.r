f <- function(text) {    count <- 0
    for (i in strsplit(text, '')[[1]]) {
        if (i %in% c('.', '!', '?', ',', '.')) {
            count <- count + 1
        }
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('bwiajegrwjd??djoda,?'), 4)))
}
test_humaneval()
