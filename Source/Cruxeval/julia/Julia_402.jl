function f(n::Int64, l::Vector{String})::Dict{Int64, Int64}> 
    archive = Dict{Int64, Int64}()
    for i in 1:n
        empty!(archive)
        for x in l
            archive[x + 10] = x * 10
        end
    end
    return archive
end
using Test

@testset begin

candidate = f;
	@test(candidate(0, ["aaa", "bbb"]) == Dict{Int64, Int64}())
end
