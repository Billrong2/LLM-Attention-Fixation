f <- function(text) {    paste0(substring(text, nchar(text)), substring(text, 1, nchar(text)-1))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hellomyfriendear'), 'rhellomyfriendea')))
}
test_humaneval()
