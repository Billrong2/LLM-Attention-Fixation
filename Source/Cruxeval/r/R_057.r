f <- function(text) {    text <- toupper(text)
    count_upper <- 0
    for (char in strsplit(text, '')[[1]]) {
        if (char %in% LETTERS) {
            count_upper <- count_upper + 1
        } else {
            return('no')
        }
    }
    return(count_upper %/% 2)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ax'), 1)))
}
test_humaneval()
