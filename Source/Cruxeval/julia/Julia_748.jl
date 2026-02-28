function f(d::Dict{String, Int})::Tuple{Tuple{String, Int}, Tuple{String, Int}} 
    keys_sorted = sort(collect(keys(d)))
    return (keys_sorted[1], d[keys_sorted[1]]), (keys_sorted[2], d[keys_sorted[2]])
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict("a" => 123, "b" => 456, "c" => 789)) == (("a", 123), ("b", 456)))
end
