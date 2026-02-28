f <- function(text, suffix, num) {    str_num <- as.character(num)
    return(tail(text, nchar(suffix) + nchar(str_num)) == paste0(suffix, str_num))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('friends and love', 'and', 3), FALSE)))
}
test_humaneval()
