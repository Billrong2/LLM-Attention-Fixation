function f(query::String, base::Dict{String, Int64})::Int64
    net_sum = 0
    for (key, val) in base
        if first(key) == query && length(key) == 3
            net_sum -= val
        elseif last(key) == query && length(key) == 3
            net_sum += val
        end
    end
    return net_sum
end

using Test

@testset begin

candidate = f;
	@test(candidate("a", Dict{String, Int64}()) == 0)
end
