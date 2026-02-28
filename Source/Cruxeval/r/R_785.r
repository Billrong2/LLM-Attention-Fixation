f <- function(n) {    
    streak <- ''
    for (c in strsplit(as.character(n), split="")[[1]]) {
        streak <- paste0(streak, sprintf("%-*s", as.numeric(c) * 2, c))
    }
    return(streak)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(1), '1 ')))
}
test_humaneval()
