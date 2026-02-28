f <- function(text, changes) {    result <- ''
    count <- 0
    changes <- strsplit(changes, '')[[1]]
    text_chars <- strsplit(text, '')[[1]]
    for (char in text_chars) {
        if (char %in% 'e') {
            result <- paste0(result, char)
        } else {
            result <- paste0(result, changes[(count %% length(changes)) + 1])
        }
        count <- count + ifelse(char %in% 'e', 0, 1)
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('fssnvd', 'yes'), 'yesyes')))
}
test_humaneval()
