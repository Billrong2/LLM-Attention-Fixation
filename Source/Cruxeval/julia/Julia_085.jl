function f(n::Int64)::Vector{Float64} 
    values = Dict{Int64, Any}(0 => 3, 1 => 4.5, 2 => '-')
    res = Dict{Any, Int64}()
    for (i, j) in values
        if i % n != 2
            res[j] = n ÷ 2
        end
    end
    return sort(collect(keys(res)))
end
using Test

@testset begin

candidate = f;
	@test(candidate(12) == [3, 4.5])
end
