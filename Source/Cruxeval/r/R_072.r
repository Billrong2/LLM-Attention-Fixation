f <- function(text) {  for (c in strsplit(text, "")[[1]]) {
    if (!grepl("[0-9]", c)) {
      return(FALSE)
    }
  }
  return(!is.na(text) && text != "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('99'), TRUE)))
}
test_humaneval()
