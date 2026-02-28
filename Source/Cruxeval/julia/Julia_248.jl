function f(a::Vector{Int64}, b::Vector{Int64})::Vector{Union{Int64, Float64}} 
    sort!(a)
    sort!(b, rev=true)
    return vcat(a, b)
end
using Test

@testset begin

candidate = f;
	@test(candidate([666], Vector{Int64}([])) == [666])
end
