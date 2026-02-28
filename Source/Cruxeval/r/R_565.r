f <- function(text) {
    vowels <- c('a', 'e', 'i', 'o', 'u')
    max_index <- -1
    for (vowel in vowels) {
        index <- gregexpr(vowel, text)[[1]][1]
        if (index > max_index) {
            max_index <- index
        }
    }
    if (max_index == -1) {
        return(NA)
    } else {
        return(max_index - 1)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qsqgijwmmhbchoj'), 13)))
}
test_humaneval()
