f <- function(text, value) {    text_list <- strsplit(text, '')[[1]]
    text_list <- c(text_list, value)
    paste(text_list, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('bcksrut', 'q'), 'bcksrutq')))
}
test_humaneval()
