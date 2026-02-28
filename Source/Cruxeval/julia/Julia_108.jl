function f(var::Union{Int, Vector{Int}, Dict{Any,Any}})::Int64
    if typeof(var) == Int
        amount = 0
    elseif typeof(var) == Vector{Int}
        amount = length(var)
    elseif typeof(var) == Dict{Any,Any}
        amount = length(keys(var))
    end
    nonzero = amount > 0 ? amount : 0
    return nonzero
end
using Test

@testset begin

candidate = f;
	@test(candidate(1) == 0)
end
