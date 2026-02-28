function f(array::Dict{Int64, Int64}, elem::Int64)::Dict{Int64, Int64}
    result = copy(array)
    while !isempty(result)
        key, value = first(result)
        delete!(result, key)
        if elem == key || elem == value
            result = merge(result, array)
        end
    end
    return result
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{Int64, Int64}(), 1) == Dict{Int64, Int64}())
end
