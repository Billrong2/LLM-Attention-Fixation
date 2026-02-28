f <- function(text, symbols) {  count <- 0
  if (nchar(symbols) > 0) {
    for (i in strsplit(symbols, '')[[1]]) {
      count <- count + 1
    }
    text <- paste(replicate(count, text), collapse = '')
  }
  return(substr(paste(replicate(nchar(text) + count*2, ' '), collapse = ''), 1, nchar(text) + count*2 - 2))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('', 'BC1ty'), '        ')))
}
test_humaneval()
