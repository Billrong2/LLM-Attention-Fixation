f <- function(out, mapping) {  for (key in names(mapping)) {
    out <- do.call("sprintf", c(out, as.list(mapping)))
    if (length(gregexpr("\\{\\w\\}", out)[[1]]) == 0) {
      break
    }
    mapping[[key]][2] <- rev(mapping[[key]][2])
  }
  return(out)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('{{{{}}}}', list()), '{{{{}}}}')))
}
test_humaneval()
