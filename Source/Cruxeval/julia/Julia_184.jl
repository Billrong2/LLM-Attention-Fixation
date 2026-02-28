function f(digits::Vector{Int64})::Vector{Int64} 
    reverse!(digits)
    if length(digits) < 2
        return digits
    end
    for i in 1:2:length(digits)-1
        digits[i], digits[i+1] = digits[i+1], digits[i]
    end
    return digits
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2]) == [1, 2])
end
