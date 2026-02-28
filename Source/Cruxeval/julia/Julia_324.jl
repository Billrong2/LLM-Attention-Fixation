function f(nums::Vector{Int64})::Vector{Int64} 
    asc = copy(nums)
    desc = reverse(asc)
    desc = desc[1:div(length(desc), 2)]
    return vcat(desc, asc, desc)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{Int64}([]))
end
