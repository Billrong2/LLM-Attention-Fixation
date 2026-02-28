f <- function(text) {    text_list <- strsplit(text, '')[[1]]
    for (i in 1:length(text_list)) {
        text_list[i] <- ifelse(text_list[i] == toupper(text_list[i]), tolower(text_list[i]), toupper(text_list[i]))
    }
    paste(text_list, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('akA?riu'), 'AKa?RIU')))
}
test_humaneval()
