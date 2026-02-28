function f(my_dict::Dict{String, Int})::Dict{Int, String}
    result = Dict{Int, String}()
    for (k, v) in my_dict
        result[v] = k
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("a" => 1, "b" => 2, "c" => 3, "d" => 2)) == Dict(1 => "a", 2 => "d", 3 => "c"))
end
