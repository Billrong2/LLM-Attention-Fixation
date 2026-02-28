f <- function(text) {    ls <- strsplit(text, "")[[1]]
    for (i in 1:length(ls)) {
        if (ls[i] != '+') {
            ls <- c('*', '+', ls)
            break
        }
    }
    paste(ls, collapse = '+')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('nzoh'), '*+++n+z+o+h')))
}
test_humaneval()
