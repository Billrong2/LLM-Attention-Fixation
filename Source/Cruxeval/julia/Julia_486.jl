function f(dic::Dict{Int64, Int64})::Dict{Int64, Int64}
    dic_op = copy(dic)
    for (key, val) in dic
        dic_op[key] = val * val
    end
    return dic_op
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(1 => 1, 2 => 2, 3 => 3)) == Dict(1 => 1, 2 => 4, 3 => 9))
end
