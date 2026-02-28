f <- function(text) {    new_text <- c()
    for (character in strsplit(text, '')[[1]]) {
        if (charToRaw(character) >= as.raw(65) & charToRaw(character) <= as.raw(90)) {
            new_text <- append(new_text, character, after = length(new_text) %/% 2)
        }
    }
    if (length(new_text) == 0) {
        new_text <- c('-')
    }
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('String matching is a big part of RexEx library.'), 'RES')))
}
test_humaneval()
