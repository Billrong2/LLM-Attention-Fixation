function f(obj::Dict{String, Int})
    for (k, v) in obj
        if v >= 0
            obj[k] = -v
        end
    end
    return obj
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("R" => 0, "T" => 3, "F" => -6, "K" => 0)) == Dict("R" => 0, "T" => -3, "F" => -6, "K" => 0))
end
