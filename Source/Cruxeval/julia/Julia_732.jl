function f(char_freq::Dict{String, Int})
    result = Dict{String, Int}()
    for (k, v) in deepcopy(char_freq)
        result[k] = div(v, 2)
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("u" => 20, "v" => 5, "b" => 7, "w" => 3, "x" => 3)) == Dict("u" => 10, "v" => 2, "b" => 3, "w" => 1, "x" => 1))
end
