function f(numbers::Vector{String}, num::Int64, val::Int64)::String 
    while length(numbers) < num
        insert!(numbers, div(length(numbers), 2) + 1, string(val))
    end
    for _ in 1:div(length(numbers), (num - 1)) - 4
        insert!(numbers, div(length(numbers), 2) + 1, string(val))
    end
    return join(numbers, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{String}([]), 0, 1) == "")
end
