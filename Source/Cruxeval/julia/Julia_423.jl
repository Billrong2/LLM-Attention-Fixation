function f(selfie::Vector{Int64})::Vector{Int64} 
    lo = length(selfie)
    for i in reverse(1:lo)
        if selfie[i] == selfie[1]
            deleteat!(selfie, lo)
        end
    end
    return selfie
end
using Test

@testset begin

candidate = f;
	@test(candidate([4, 2, 5, 1, 3, 2, 6]) == [4, 2, 5, 1, 3, 2])
end
