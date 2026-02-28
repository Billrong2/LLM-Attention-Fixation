function f(array::Vector{Int64}, lst::Vector{Int64})::Vector{Int64}
    append!(array, lst)
    filter(x -> x % 2 == 0, array)
    return filter(x -> x >= 10, array)
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 15], [15, 1]) == [15, 15])
end
