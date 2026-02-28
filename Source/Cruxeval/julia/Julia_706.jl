function f(r::String, w::String)::Vector{String} 
    a = []
    if r[1] == w[1] && w[end] == r[end]
        push!(a, r)
        push!(a, w)
    else
        push!(a, w)
        push!(a, r)
    end
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate("ab", "xy") == ["xy", "ab"])
end
