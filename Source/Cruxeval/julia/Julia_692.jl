function f(array::Vector{Int64})::Vector{Int64} 
    a = Vector{Int64}()
    reverse!(array)
    for i in 1:length(array)
        if array[i] != 0
            push!(a, array[i])
        end
    end
    reverse!(a)
    return a
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{Int64}([]))
end
