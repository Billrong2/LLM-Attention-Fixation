f <- function(text) {    text <- gsub(' x', ' x.', text)
    if (all(substring(text, 1, 1) <= toupper(substring(text, 1, 1)))) {
        return('correct')
    }
    text <- gsub(' x.', ' x', text)
    return('mixed')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('398 Is A Poor Year To Sow'), 'correct')))
}
test_humaneval()
