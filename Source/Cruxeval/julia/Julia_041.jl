function f(array::Vector{Int64}, values::Vector{Int64})::Vector{Int64} 
    reverse!(array)
    for value in values
        insert!(array, length(array) ÷ 2 + 1, value)
    end
    reverse!(array)
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([58], [21, 92]) == [58, 92, 21])
end
