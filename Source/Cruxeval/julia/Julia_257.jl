function f(text::Vector{String})::Vector{Vector{String}} 
    ls = []
    for x in text
        push!(ls, split(x, '\n'))
    end
    return ls
end
using Test

@testset begin

candidate = f;
	@test(candidate(["Hello World
\"I am String\""]) == [["Hello World", "\"I am String\""]])
end
