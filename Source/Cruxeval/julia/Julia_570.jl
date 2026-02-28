function f(array::Vector{Int}, index::Int, value::Int)::Vector{Int}
    new_array = [index + 1; array...]  # Insert index + 1 at the beginning
    if value >= 1
        new_array = [new_array[1:index]; value; new_array[index+1:end]]  # Insert value at index
    end
    return new_array
end
using Test

@testset begin

candidate = f;
	@test(candidate([2], 0, 2) == [2, 1, 2])
end
