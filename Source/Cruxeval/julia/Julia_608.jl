function f(aDict::Dict{Int64, Int64})::Dict{Int64, Int64}
    # transpose the keys and values into a new dict
    return Dict([v for v in aDict])
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(1 => 1, 2 => 2, 3 => 3)) == Dict(1 => 1, 2 => 2, 3 => 3))
end
