function f(dict0::Dict{Int, Int})::Dict{Int, Int}
    new = copy(dict0)
    for i in 1:length(keys(new)) - 1
        key_list = sort(collect(keys(new)))
        dict0[key_list[i]] = i - 1
    end
    return dict0
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(2 => 5, 4 => 1, 3 => 5, 1 => 3, 5 => 1)) == Dict(2 => 1, 4 => 3, 3 => 2, 1 => 0, 5 => 1))
end
