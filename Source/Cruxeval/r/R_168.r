f <- function(text, new_value, index) {
    old_char <- substr(text, start = index + 1, stop = index + 1)
    return (gsub(old_char, new_value, text, fixed = TRUE))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('spain', 'b', 4), 'spaib')))
}
test_humaneval()
