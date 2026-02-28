function f(zoo::Dict{String, String})::Dict{String, String}
    return Dict(v => k for (k, v) in pairs(zoo))
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("AAA" => "fr")) == Dict("fr" => "AAA"))
end
