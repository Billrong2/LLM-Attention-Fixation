function f(strings::Vector{String})::Dict{String, Int64}> 
    occurances = Dict{String, Int64}()
    for string in strings
        if !haskey(occurances, string)
            occurances[string] = count(x -> x == string, strings)
        end
    end
    return occurances
end
using Test

@testset begin

candidate = f;
	@test(candidate(["La", "Q", "9", "La", "La"]) == Dict("La" => 3, "Q" => 1, "9" => 1))
end
