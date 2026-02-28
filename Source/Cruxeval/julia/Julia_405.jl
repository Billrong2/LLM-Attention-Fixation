function f(xs::Vector{Int64})::Vector{Int64} 
    new_x = xs[1] - 1
    xs = xs[2:end]
    while new_x <= xs[1]
        xs = xs[2:end]
        new_x -= 1
    end
    xs = [new_x; xs...]
    return xs
end
using Test

@testset begin

candidate = f;
	@test(candidate([6, 3, 4, 1, 2, 3, 5]) == [5, 3, 4, 1, 2, 3, 5])
end
