function f(array::Vector{String}, arr::Vector{String})::Vector{String} 
    result = []
    for s in arr
        result .= filter(x -> x != "", split(s, arr[findfirst(x -> x == s, array)]))
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{String}([]), Vector{String}([])) == Vector{String}([]))
end
