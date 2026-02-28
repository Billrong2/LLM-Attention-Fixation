f <- function(text, value) {    ls <- strsplit(text, '')[[1]]
    if ((sum(ls == value) %% 2) == 0) {
        while (value %in% ls) {
            ls <- ls[ls != value]
        }
    } else {
        ls <- c()
    }
    paste(ls, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abbkebaniuwurzvr', 'm'), 'abbkebaniuwurzvr')))
}
test_humaneval()
