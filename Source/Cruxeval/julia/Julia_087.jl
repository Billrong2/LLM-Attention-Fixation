function f(nums::Vector{Int64})::String 
    reverse!(nums)
    return join(string.(nums))
end
using Test

@testset begin

candidate = f;
	@test(candidate([-1, 9, 3, 1, -2]) == "-2139-1")
end
