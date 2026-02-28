function f(seq::Vector{String}, v::String)::Vector{String}
    a = String[]
    for i in seq
        if endswith(i, v)
            push!(a, i^2)
        end
    end
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate(["oH", "ee", "mb", "deft", "n", "zz", "f", "abA"], "zz") == ["zzzz"])
end
