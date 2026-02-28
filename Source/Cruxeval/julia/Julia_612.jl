function f(d::Dict{String, Int64})::Dict{String, Int64}
    return Dict{String, Int64}(collect(d))
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("a" => 42, "b" => 1337, "c" => -1, "d" => 5)) == Dict("a" => 42, "b" => 1337, "c" => -1, "d" => 5))
end
