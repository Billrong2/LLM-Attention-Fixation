function f(d::Dict{Int64, String}, get_ary::Vector{Int64})::Vector{Union{String, Nothing}} 
    result = []
    for key in get_ary
        push!(result, get(d, key, nothing))
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(3 => "swims like a bull"), [3, 2, 5]) == ["swims like a bull", nothing, nothing])
end
