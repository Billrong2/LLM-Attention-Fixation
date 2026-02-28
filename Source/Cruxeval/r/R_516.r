f <- function(strings, substr) {   
  list <- unlist(lapply(strings, function(s) {if (startsWith(s, substr)) s else NULL}))
  list[order(nchar(list))]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('condor', 'eyes', 'gay', 'isa'), 'd'), c())))
}
test_humaneval()
