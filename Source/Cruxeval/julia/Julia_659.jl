function f(bots::Vector{String})::Int64 
    clean = filter(x -> !all(isuppercase, x), bots)
    clean = [x[1:2] * x[end-2:end] for x in clean]
    return length(clean)
end
using Test

@testset begin

candidate = f;
	@test(candidate(["yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis"]) == 4)
end
