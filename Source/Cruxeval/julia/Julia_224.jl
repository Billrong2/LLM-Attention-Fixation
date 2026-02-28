function f(array::Vector{String}, value::Int64)::Dict{String, Int64}> 
    reverse!(array)
    pop!(array)
    odd = []
    while length(array) > 0
        tmp = Dict()
        tmp[pop!(array)] = value
        push!(odd, tmp)
    end
    result = Dict()
    while length(odd) > 0
        merge!(result, pop!(odd))
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(["23"], 123) == Dict{String, Int64}())
end
