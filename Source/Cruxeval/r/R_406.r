f <- function(text) {    ls <- strsplit(text, '')[[1]]
    ls[c(1, length(ls))] <- toupper(ls[c(length(ls), 1)])
    paste(ls, collapse='') %in% c(tolower(ls), toupper(ls))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Josh'), FALSE)))
}
test_humaneval()
