function f(xs::Vector{Int64})::Vector{Int64}
    for idx in range(1, stop=length(xs), step=1)
        pushfirst!(xs, popat!(xs, length(xs)))
    end
    return xs
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3]) == [1, 2, 3])
end
