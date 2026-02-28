function f(parts::Vector{Tuple{String, Int64}})::Vector{Int64} 
    return collect(values(Dict(parts)))
end
using Test

@testset begin

candidate = f;
	@test(candidate([("u", 1), ("s", 7), ("u", -5)]) == [-5, 7])
end
