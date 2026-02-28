function f(d::Dict{Int64, Int64})::Vector{Tuple{Int64, Int64}}
    sorted_pairs = sort(collect(pairs(d)), by = x -> length(string(string(x.first) * string(x.second))))
    return [(k, v) for (k, v) in sorted_pairs if k < v]
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(55 => 4, 4 => 555, 1 => 3, 99 => 21, 499 => 4, 71 => 7, 12 => 6)) == [(1, 3), (4, 555)])
end
