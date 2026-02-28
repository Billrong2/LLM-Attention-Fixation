function f(numbers::Vector{Int64}, index::Int64)::Vector{Int64} 
    return vcat(numbers[1:index], numbers[index+1:end])
end
using Test

@testset begin

candidate = f;
	@test(candidate([-2, 4, -4], 0) == [-2, 4, -4])
end
