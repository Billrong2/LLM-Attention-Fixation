function f(array::Vector{Int64})::Vector{Int64} 
    output = copy(array)
    output[1:2:end] .= reverse(output[end:-2:1])
    reverse!(output)
    return output
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{Int64}([]))
end
