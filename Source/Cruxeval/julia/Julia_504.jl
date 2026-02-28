function f(values::Vector{Int64})::Vector{Int64} 
    sort!(values)
    return values
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1, 1, 1]) == [1, 1, 1, 1])
end
