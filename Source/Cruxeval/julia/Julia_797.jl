function f(dct::Dict{String, Int})::Vector{Tuple{String, Int}}
    lst = []
    for key in sort(collect(keys(dct)))
        push!(lst, (key, dct[key]))
    end
    return lst
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("a" => 1, "b" => 2, "c" => 3)) == [("a", 1), ("b", 2), ("c", 3)])
end
