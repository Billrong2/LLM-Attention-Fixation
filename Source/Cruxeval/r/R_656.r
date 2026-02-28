f <- function(letters) {    a <- c()
    for (i in 1:length(letters)) {
        if (letters[i] %in% a) {
            return('no')
        }
        a <- c(a, letters[i])
    }
    return('yes')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('b', 'i', 'r', 'o', 's', 'j', 'v', 'p')), 'yes')))
}
test_humaneval()
