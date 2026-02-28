function f(code::String)::String 
    lines = split(code, ']')
    result = []
    level = 0
    for line in lines
        push!(result, line[1] * " " * "  "^level * line[2:end])
        level += count(occursin.(['{'], line)) - count(occursin.(['}'], line))
    end
    return join(result, "\n")
end
using Test

@testset begin

candidate = f;
	@test(candidate("if (x) {y = 1;} else {z = 1;}") == "i f (x) {y = 1;} else {z = 1;}")
end
