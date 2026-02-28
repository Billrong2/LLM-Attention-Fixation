function f(items::Vector{Tuple{Int64, String}})::Vector{Dict{Int64, String}}
    result = []
    for number in items
        d = Dict{Int64, String}(items)
        pop!(d)
        push!(result, d)
        items = collect(d)
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate([(1, "pos")]) == [Dict{Int64, Int64}()])
end
