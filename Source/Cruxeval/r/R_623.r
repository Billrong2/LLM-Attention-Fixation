f <- function(text, rules) {    for (rule in rules) {
        if (rule == '@') {
            text <- strsplit(text, "")[[1]]
            text <- rev(text)
            text <- paste(text, collapse = "")
        } else if (rule == '~') {
            text <- toupper(text)
        } else if (nchar(text) > 0 && substr(text, nchar(text), nchar(text)) == rule) {
            text <- substr(text, 1, nchar(text) - 1)
        }
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hi~!', c('~', '`', '!', '&')), 'HI~')))
}
test_humaneval()
