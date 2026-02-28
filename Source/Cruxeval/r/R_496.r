f <- function(text, value) {
    if (is.character(value)) {
        return (sum(strsplit(text, '')[[1]] == value) + 
                sum(strsplit(text, '')[[1]] == tolower(value)))
    }
    return (sum(strsplit(text, '')[[1]] == value))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('eftw{ьТсk_1', '\\'), 0)))
}
test_humaneval()
