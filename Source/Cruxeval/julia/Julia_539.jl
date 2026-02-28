function f(array::Vector{String})::Vector{String} 
    c = array
    array_copy = array

    while true
        push!(c, "_")
        if c == array_copy
            array_copy[findfirst(x -> x == "_", c)] = ""
            break
        end
    end
    return array_copy
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{String}([])) == [""])
end
