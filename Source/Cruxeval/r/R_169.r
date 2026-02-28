f <- function(text) {    ls <- strsplit(text, split = '')[[1]]
    total <- (nchar(text) - 1) * 2
    for (i in 1:total) {
        if (i %% 2 == 1) {
            ls <- c(ls, '+')
        } else {
            ls <- c('+', ls)
        }
    }
    paste(ls, collapse = '') 
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('taole'), '++++taole++++')))
}
test_humaneval()
