f <- function(s, sep) {
    s <- paste0(s, sep)
    sub(paste0(sep, '$'), '', s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('234dsfssdfs333324314', 's'), '234dsfssdfs333324314')))
}
test_humaneval()
