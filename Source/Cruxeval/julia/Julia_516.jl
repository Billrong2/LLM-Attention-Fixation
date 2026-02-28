function f(strings::Vector{String}, substr::String)::Vector{String} 
    list = filter(s -> startswith(s, substr), strings)
    return sort(list, by = x -> length(x))
end
using Test

@testset begin

candidate = f;
	@test(candidate(["condor", "eyes", "gay", "isa"], "d") == Vector{String}([]))
end
