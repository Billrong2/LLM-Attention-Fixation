function f(numbers::Vector{Int64}, elem::Int64, idx::Int64)::Vector{Int64}
    if idx > length(numbers)
        push!(numbers, elem)
    else
        insert!(numbers, idx, elem)
    end
    return numbers
end

using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3], 8, 5) == [1, 2, 3, 8])
end
