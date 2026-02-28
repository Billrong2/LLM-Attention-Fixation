function f(ls::Vector{Vector{Int64}}, n::Int64)::Union{Vector{Int64}, Int64} 
    answer = 0
    for i in ls
        if i[1] == n
            answer = i
        end
    end
    return answer
end
using Test

@testset begin

candidate = f;
	@test(candidate([[1, 9, 4], [83, 0, 5], [9, 6, 100]], 1) == [1, 9, 4])
end
