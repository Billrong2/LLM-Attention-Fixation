function f(lst::Vector{Int64})::Vector{Int64}
    lst[2:3] = reverse(lst[2:3])
    return lst
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3]) == [1, 3, 2])
end
