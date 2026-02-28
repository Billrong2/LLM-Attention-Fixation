function f(original::Dict{Int, Int}, string::Dict{Int, Int})::Dict{Int, Int}
    temp = deepcopy(original)
    for (a, b) in string
        temp[b] = a
    end
    return temp
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(1 => -9, 0 => -7), Dict(1 => 2, 0 => 3)) == Dict(1 => -9, 0 => -7, 2 => 1, 3 => 0))
end
