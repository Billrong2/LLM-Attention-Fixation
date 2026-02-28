function f(array::Vector{Int}, num::Int)::Vector{Int}
    reverse = false
    if num < 0
        reverse = true
        num *= -1
    end
    
    array = reverse!(copy(array)) * num
    l = length(array)
    
    if reverse
        array = reverse!(copy(array))
    end
    
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2], 1) == [2, 1])
end
