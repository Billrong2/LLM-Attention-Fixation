function f(dict1::Dict{String, Int}, dict2::Dict{String, Int})::Dict{String, Int}
    result = copy(dict1)
    for key in keys(dict2)
        result[key] = dict2[key]
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("disface" => 9, "cam" => 7), Dict("mforce" => 5)) == Dict("disface" => 9, "cam" => 7, "mforce" => 5))
end
