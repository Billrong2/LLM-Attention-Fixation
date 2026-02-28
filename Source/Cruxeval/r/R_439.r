f <- function(value) {    parts <- unlist(strsplit(value, ' '))
    paste0(parts[seq(1, length(parts), by=2)], collapse='')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('coscifysu'), 'coscifysu')))
}
test_humaneval()
