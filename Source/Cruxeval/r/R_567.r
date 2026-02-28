f <- function(s, n) {  ls <- strsplit(s, " ")[[1]]
  out <- character(0)
  while (length(ls) >= n) {
    out <- c(out, tail(ls, n))
    ls <- head(ls, -n)
  }
  return(c(ls, paste(out, collapse = "_")))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('one two three four five', 3), c('one', 'two', 'three_four_five'))))
}
test_humaneval()
