function f(list_::Vector{String}, num::Int64)::Vector{String} 
    temp = []
    for i in list_
        i = repeat(string(i) * ",", div(num, 2))
        push!(temp, i)
    end
    return temp
end
using Test

@testset begin

candidate = f;
	@test(candidate(["v"], 1) == [""])
end
