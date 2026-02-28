function f(no::Vector{String})::Int64 
    d = Dict{String, Bool}(no .=> false)
    return length(keys(d))
end
using Test

@testset begin

candidate = f;
	@test(candidate(["l", "f", "h", "g", "s", "b"]) == 6)
end
