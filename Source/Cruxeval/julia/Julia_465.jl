function f(seq::Vector{String}, value::String)::Dict{String, String}> 
    roles = Dict{String, String}(zip(seq, fill("north", length(seq))))
    if !isempty(value)
        for key in split(value, ", ")
            roles[key] = key
        end
    end
    return roles
end
using Test

@testset begin

candidate = f;
	@test(candidate(["wise king", "young king"], "") == Dict("wise king" => "north", "young king" => "north"))
end
