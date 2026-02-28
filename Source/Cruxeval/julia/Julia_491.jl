function f(xs::Vector{Int64})::Vector{Int64}
    for i in 1:length(xs)
        extend_arr = [xs[end-i+1], xs[end-i+1]]
        append!(xs, extend_arr)
    end
    return xs
end

using Test

@testset begin

candidate = f;
	@test(candidate([4, 8, 8, 5]) == [4, 8, 8, 5, 5, 5, 5, 5, 5, 5, 5, 5])
end
