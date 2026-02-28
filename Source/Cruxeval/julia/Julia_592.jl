function f(numbers::Vector{Int64})::Vector{Int64} 
    new_numbers = Int64[]
    for i in reverse(1:length(numbers))
        push!(new_numbers, numbers[i])
    end
    return new_numbers
end
using Test

@testset begin

candidate = f;
	@test(candidate([11, 3]) == [3, 11])
end
