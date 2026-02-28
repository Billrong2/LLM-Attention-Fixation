function f(d::Dict{Int64, Int64})::Vector{Int64}
    result = Vector{Int64}(undef, length(d))
    a = b = 0
    while !isempty(d)
        key, value = pop!(d)
        result[a + 1] = value  # Julia is 1-indexed
        a, b = b, (b + 1) % length(result)
    end
    return result
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{Int64, Int64}()) == Vector{Int64}([]))
end
