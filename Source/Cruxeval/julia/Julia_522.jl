function f(numbers::Vector{Int64})::Vector{Float64} 
    floats = [n % 1 for n in numbers]
    return 1 in floats ? floats : Float64[]
end
using Test

@testset begin

candidate = f;
	@test(candidate([100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119]) == Vector{Float64}([]))
end
