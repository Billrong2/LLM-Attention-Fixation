function f(array::Vector{Int64}, ind::Int64, elem::Int64)::Vector{Int64} 
    insertion_index = ind < 0 ? -5 : (ind > length(array) ? length(array) : ind + 1)
    insertion_index = insertion_index < 0 ? 0 : insertion_index
    insertion_index = insertion_index > length(array) ? length(array) : insertion_index
    insertion_index += 1
    insert!(array, insertion_index, elem)
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 5, 8, 2, 0, 3], 2, 7) == [1, 5, 8, 7, 2, 0, 3])
end
