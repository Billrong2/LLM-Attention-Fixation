function f(text::String)::Vector{String} 
    ls = split(text)
    lines = split(join(ls[1:3:end]), '\n')
    res = []
    for i in 0:1
        ln = ls[2:3:end]
        if 3*i + 2 <= length(ln)
            push!(res, join(ln[3*i+1:3*(i+1)], " "))
        end
    end
    return vcat(lines, res)
end
using Test

@testset begin

candidate = f;
	@test(candidate("echo hello!!! nice!") == ["echo"])
end
