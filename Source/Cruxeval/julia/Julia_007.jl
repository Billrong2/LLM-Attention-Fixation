function f(list::Vector{Int64})::Vector{Int64}
    original = copy(list)
    while length(list) > 1
        popat!(list, length(list))
        for i in 1:length(list)
            popat!(list, i)
        end
    end
    list = copy(original)
    if !isempty(list)
        popfirst!(list)
    end
    return list
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{Int64}([]))
end
