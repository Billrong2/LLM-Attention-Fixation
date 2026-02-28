f <- function(multi_string) {    cond_string <- sapply(strsplit(multi_string, ' ')[[1]], function(x) all(charToRaw(x) < 128))
    if (any(cond_string)) {
        paste(na.omit(strsplit(multi_string, ' ')[[1]][cond_string]), collapse = ', ')
    } else {
        return('')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('I am hungry! eat food.'), 'I, am, hungry!, eat, food.')))
}
test_humaneval()
