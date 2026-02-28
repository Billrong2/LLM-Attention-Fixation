function f(array::Vector{Int64})::Vector{String} 
    just_ns = map(num -> "n"^num, array)
    final_output = String[]
    for wipe in just_ns
        push!(final_output, wipe)
    end
    return final_output
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{String}([]))
end
