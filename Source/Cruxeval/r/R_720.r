f <- function(items, item) {
    while (items[length(items)] == item) {
        items <- items[-length(items)]
    }
    items <- append(items, item)
    return(length(items))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('bfreratrrbdbzagbretaredtroefcoiqrrneaosf'), 'n'), 2)))
}
test_humaneval()
