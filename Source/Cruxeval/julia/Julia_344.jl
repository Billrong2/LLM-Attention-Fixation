function f(lst::Vector{Int64})::Vector{Int64}
    operation = reverse
    new_list = copy(lst)
    sort(new_list)
    operation(new_list)
    return lst
end

using Test

@testset begin

candidate = f;
	@test(candidate([6, 4, 2, 8, 15]) == [6, 4, 2, 8, 15])
end
