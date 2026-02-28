function f(dic::Dict{Int64, String})::Dict{String, Int64}
    dic2 = Dict(zip(values(dic), keys(dic)))
    return dic2
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(-1 => "a", 0 => "b", 1 => "c")) == Dict("a" => -1, "b" => 0, "c" => 1))
end
