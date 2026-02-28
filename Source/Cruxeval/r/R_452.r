f <- function(text) {    counter <- 0
    for (char in strsplit(text, '')[[1]]) {
        if (char %in% letters) {
            counter <- counter + 1
        }
    }
    return(counter)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('l000*'), 1)))
}
test_humaneval()
