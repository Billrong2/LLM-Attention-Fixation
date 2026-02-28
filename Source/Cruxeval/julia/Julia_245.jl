function f(alphabet::String, s::String)::Vector{String} 
    a = [x for x in split(alphabet, "") if contains(uppercase(x), uppercase(s))]
    if uppercase(s) == s
        push!(a, "all_uppercased")
    end
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate("abcdefghijklmnopqrstuvwxyz", "uppercased # % ^ @ ! vz.") == Vector{String}([]))
end
