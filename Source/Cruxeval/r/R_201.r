f <- function(text) {    chars <- strsplit(text, '')[[1]]
    nums <- chars[grepl('[0-9]', chars)]
    paste0(rev(nums), collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('--4yrw 251-//4 6p'), '641524')))
}
test_humaneval()
