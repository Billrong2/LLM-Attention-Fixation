function f(lst::Vector{Int64}, start::Int64, end_val::Int64)::Int64 
    count = 0
    for i in start:end_val-1
        for j in i+1:end_val
            if lst[i+1] != lst[j]
                count += 1
            end
        end
    end
    return count
end

using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 4, 3, 2, 1], 0, 3) == 3)
end
