f <- function(text, letter) {
    if (letter %in% letters) letter <- toupper(letter)
    text <- gsub(letter, toupper(letter), text, fixed = TRUE)
    text <- paste0(toupper(substring(text, 1, 1)), substring(text, 2))
    return(text)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('E wrestled evil until upperfeat', 'e'), 'E wrestled evil until upperfeat')))
}
test_humaneval()
