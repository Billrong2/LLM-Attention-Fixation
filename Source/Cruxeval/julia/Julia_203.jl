function f(d::Dict{String, String})::Dict{String, String}
    empty!(d)
    return d
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict("a" => "3", "b" => "-1", "c" => "Dum")) == Dict{String, String}())
end
