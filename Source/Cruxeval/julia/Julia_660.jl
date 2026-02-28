function f(num::Int64)::Int64 
    initial = [1]
    total = initial
    for _ in 1:num
        total = [1; [x+y for (x, y) in zip(total, total[2:end])]]
        push!(initial, total[end])
    end
    return sum(initial)
end
using Test

@testset begin

candidate = f;
	@test(candidate(3) == 4)
end
