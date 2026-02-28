f <- function(text, search_chars, replace_chars) {    trans_table <- chartr(search_chars, replace_chars, text)
    return(trans_table)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mmm34mIm', 'mm3', ',po'), 'pppo4pIp')))
}
test_humaneval()
