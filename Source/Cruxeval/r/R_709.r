f <- function(text) {    my_list <- strsplit(text, " ")[[1]]
    my_list <- sort(my_list, decreasing = TRUE)
    return(paste(my_list, collapse = " "))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a loved'), 'loved a')))
}
test_humaneval()
