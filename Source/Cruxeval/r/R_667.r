f <- function(text) {    new_text <- c()
    for (i in seq_len(nchar(text) %/% 3)) {
        start <- (i - 1) * 3 + 1
        end <- start + 2
        new_text <- c(new_text, paste0('< ', substr(text, start, end), ' level=', i - 1, ' >'))
    }
    last_item <- substr(text, (nchar(text) %/% 3) * 3 + 1, nchar(text))
    new_text <- c(new_text, paste0('< ', last_item, ' level=', nchar(text) %/% 3, ' >'))
    return(new_text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('C7'), c('< C7 level=0 >'))))
}
test_humaneval()
