function f(single_digit::Int64)::Vector{Int64} 
    result = Int64[]
    for c in 1:10
        if c != single_digit
            push!(result, c)
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(5) == [1, 2, 3, 4, 6, 7, 8, 9, 10])
end
