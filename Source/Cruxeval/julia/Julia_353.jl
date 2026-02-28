function f(x::Vector{Int64})::Int64 
    if x == []
        return -1
    else
        cache = Dict{Int64, Int64}()
        for item in x
            if haskey(cache, item)
                cache[item] += 1
            else
                cache[item] = 1
            end
        end
        return maximum(values(cache))
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 0, 2, 2, 0, 0, 0, 1]) == 4)
end
