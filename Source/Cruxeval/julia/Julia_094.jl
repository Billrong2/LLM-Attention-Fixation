function f(a::Dict{String, Int}, b::Dict{String, Int})::Dict{String, Int}
    return merge(a, b)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("w" => 5, "wi" => 10), Dict("w" => 3)) == Dict("w" => 3, "wi" => 10))
end
