function f(L::Vector{Int64})::Vector{Int64} 
    N = length(L)
    for k in 1:N÷2
        i = k
        j = N - k + 1
        while i < j
            # swap elements
            L[i], L[j] = L[j], L[i]
            # update i, j
            i += 1
            j -= 1
        end
    end
    return L
end
using Test

@testset begin

candidate = f;
	@test(candidate([16, 14, 12, 7, 9, 11]) == [11, 14, 7, 12, 9, 16])
end
