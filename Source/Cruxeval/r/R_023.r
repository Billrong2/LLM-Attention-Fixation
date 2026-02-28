f <- function(text, chars) {    if (nchar(chars) > 0) {
        text <- sub(paste0('[' , chars, ']*$'), '', text)
    } else {
        text <- sub('[ ]*$', '', text)
    }
    
    if (text == '') {
        return('-')
    }
    
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('new-medium-performing-application - XQuery 2.2', '0123456789-'), 'new-medium-performing-application - XQuery 2.')))
}
test_humaneval()
