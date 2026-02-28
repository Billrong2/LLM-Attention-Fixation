function f(dict::Dict{Int64, Int64})::Dict{Int64, Int64}
    result = copy(dict)
    remove_keys = []
    for (k, v) in dict
        if haskey(dict, v)
            delete!(result, k)
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(-1 => -1, 5 => 5, 3 => 6, -4 => -4)) == Dict(3 => 6))
end
