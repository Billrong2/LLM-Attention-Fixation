function f(chemicals::Vector{String}, num::Int64)::Vector{String} 
    fish = chemicals[2:end]
    reverse!(chemicals)
    for i in 1:num
        push!(fish, splice!(chemicals, 2))
    end
    reverse!(chemicals)
    return chemicals
end
using Test

@testset begin

candidate = f;
	@test(candidate(["lsi", "s", "t", "t", "d"], 0) == ["lsi", "s", "t", "t", "d"])
end
