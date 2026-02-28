function f(s::String, n::Int64)::Vector{String} 
    ls = split(s, " ")
    out = String[]
    while length(ls) >= n
        append!(out, ls[end-n+1:end])
        ls = ls[1:end-n]
    end
    
    return vcat(ls, join(out, "_"))
end
using Test

@testset begin

candidate = f;
	@test(candidate("one two three four five", 3) == ["one", "two", "three_four_five"])
end
