function f(start::Int64, end_val::Int64, interval::Int64)::Int64 
    steps = collect(start:interval:end_val)
    if 1 in steps
        steps[end] = end_val + 1
    end
    return length(steps)
end

using Test

@testset begin

candidate = f;
	@test(candidate(3, 10, 1) == 8)
end
