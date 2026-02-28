f <- function(text, strip_chars) {
    rev_text <- paste(rev(strsplit(text, split = "")[[1]]), collapse = "")
    strip_left <- sub(paste0("^[", strip_chars, "]*"), "", rev_text)
    final_text <- paste(rev(strsplit(strip_left, split = "")[[1]]), collapse = "")
    final_text
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('tcmfsmj', 'cfj'), 'tcmfsm')))
}
test_humaneval()
