f <- function(name) {    paste0("| ", paste(strsplit(name, " ")[[1]], collapse = " "), " |")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('i am your father'), '| i am your father |')))
}
test_humaneval()
