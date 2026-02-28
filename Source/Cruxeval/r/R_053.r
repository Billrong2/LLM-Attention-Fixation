f <- function(text) {
    occ <- list()
    for(ch in strsplit(text, "")[[1]]) {
        name <- switch(ch, "a" = "b", "b" = "c", "c" = "d", "d" = "e", "e" = "f", ch)
        if(is.null(occ[[name]])) {
            occ[[name]] <- 1
        } else {
            occ[[name]] <- occ[[name]] + 1
        }
    }
    as.numeric(occ)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('URW rNB'), c(1, 1, 1, 1, 1, 1, 1))))
}
test_humaneval()
