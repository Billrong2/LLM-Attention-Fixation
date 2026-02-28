function f(number::Int64)::Vector{String} 
    transl = Dict("A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5)
    result = String[]
    for (key, value) in transl
        if value % number == 0
            push!(result, key)
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(2) == ["B", "D"])
end
