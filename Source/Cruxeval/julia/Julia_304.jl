function f(d::Dict{Int64, Int64})::Dict{Int64, Int64}
    sorted_items = sort(collect(d), by=x->x[1], rev=true)
    key1 = sorted_items[1][1]
    val1 = pop!(d, key1)
    key2 = sorted_items[2][1]
    val2 = pop!(d, key2)
    return Dict(key1 => val1, key2 => val2)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(2 => 3, 17 => 3, 16 => 6, 18 => 6, 87 => 7)) == Dict(87 => 7, 18 => 6))
end
