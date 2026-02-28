f <- function(text, char) {    return (char %in% letters) && all(char %in% letters) && all(char == tolower(char)) && all(text == tolower(text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abc', 'e'), TRUE)))
}
test_humaneval()
