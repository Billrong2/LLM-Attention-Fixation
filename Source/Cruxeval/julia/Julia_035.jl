function f(pattern::String, items::Vector{String})::Vector{Int64}
    result = Int64[]
    for text in items
        pos = findlast(pattern, text)
        if pos !== nothing
            push!(result, pos.start - 1)
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(" B ", [" bBb ", " BaB ", " bB", " bBbB ", " bbb"]) == Vector{Int64}([]))
end
