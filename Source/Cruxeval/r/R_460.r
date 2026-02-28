f <- function(text, amount) {    length <- nchar(text)
    pre_text <- '|'
    
    if (amount >= length) {
        extra_space <- amount - length
        pre_text <- paste0(pre_text, rep(' ', extra_space %/% 2, collapse = ''))
        return(paste0(pre_text, text, pre_text))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('GENERAL NAGOOR', 5), 'GENERAL NAGOOR')))
}
test_humaneval()
