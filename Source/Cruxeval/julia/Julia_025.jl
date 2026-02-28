function f(d::Dict{String, Int})::Dict{String, Int}
    d = copy(d)
    pop!(d)
    return d
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("l" => 1, "t" => 2, "x:" => 3)) == Dict("l" => 1, "t" => 2))
end
