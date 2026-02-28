function f(matr::Vector{Vector{Int64}}, insert_loc::Int64)::Vector{Vector{Int64}} 
    insert_loc += 1
    matr = vcat(matr[1:insert_loc-1], [[]], matr[insert_loc:end])
    return matr
end
using Test

@testset begin

candidate = f;
	@test(candidate([[5, 6, 2, 3], [1, 9, 5, 6]], 0) == [[], [5, 6, 2, 3], [1, 9, 5, 6]])
end
