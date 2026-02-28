function f(instagram::Vector{String}, imgur::Vector{String}, wins::Int64)::Union{String, Vector{String}} 
    photos = [instagram, imgur]
    if instagram == imgur
        return wins
    end
    if wins == 1
        return pop!(photos)
    else
        reverse!(photos)
        return pop!(photos)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate(["sdfs", "drcr", "2e"], ["sdfs", "dr2c", "QWERTY"], 0) == ["sdfs", "drcr", "2e"])
end
