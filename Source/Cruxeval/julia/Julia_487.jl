function f(dict::Dict{Int64, String})::Vector{Int64} 
    even_keys = Int[]
    for key in keys(dict)
        if key % 2 == 0
            push!(even_keys, key)
        end
    end
    return even_keys
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(4 => "a")) == [4])
end
