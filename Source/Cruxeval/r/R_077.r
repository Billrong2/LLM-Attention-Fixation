f <- function(text, character) {
    text <- paste(text, collapse = '')
    subj <- strsplit(text, '')[[1]]
    if (character %in% subj) {
        subj <- subj[max(which(subj == character)):length(subj)]
        paste(rep(subj, times = sum(subj == character)), collapse = '')
    } else {
        return("")
    }
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('h ,lpvvkohh,u', 'i'), '')))
}
test_humaneval()
