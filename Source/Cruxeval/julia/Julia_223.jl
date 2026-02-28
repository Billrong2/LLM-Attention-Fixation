function f(array::Vector{Int64}, target::Int64)::Int64 
    count, i = 0, 1
    for j in 2:length(array)
        if (array[j] > array[j-1]) && (array[j] <= target)
            count += i
        elseif array[j] <= array[j-1]
            i = 1
        else
            i += 1
        end
    end
    return count
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, -1, 4], 2) == 1)
end
