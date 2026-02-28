f <- function(text) {   
    text = tolower(text)
    capitalize = paste(toupper(substring(text, 1, 1)), substring(text, 2), sep = "")
    paste0(substring(text, 1, 1), substring(capitalize, 2))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('this And cPanel'), 'this and cpanel')))
}
test_humaneval()
