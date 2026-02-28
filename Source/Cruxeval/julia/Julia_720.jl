function f(items::Vector{String}, item::String)::Int64 
    while items[end] == item
        pop!(items)
    end
    push!(items, item)
    return length(items)
end
using Test

@testset begin

candidate = f;
	@test(candidate(["bfreratrrbdbzagbretaredtroefcoiqrrneaosf"], "n") == 2)
end
