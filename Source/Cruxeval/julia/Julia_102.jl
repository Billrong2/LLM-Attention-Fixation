function f(names::Vector{String}, winners::Vector{String})::Vector{Int64} 
    ls = [findfirst(name .== names) for name in names if name in winners]
    ls = filter(x-> x != nothing, ls) |> x->sort(x, rev=true)
    return ls
end
using Test

@testset begin

candidate = f;
	@test(candidate(["e", "f", "j", "x", "r", "k"], ["a", "v", "2", "im", "nb", "vj", "z"]) == Vector{Int64}([]))
end
