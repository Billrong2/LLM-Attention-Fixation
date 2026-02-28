function f(arr::Vector{Int64})::Vector{Int64} 
    return reverse(arr)
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 0, 1, 9999, 3, -5]) == [-5, 3, 9999, 1, 0, 2])
end
