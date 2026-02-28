function f(years::Vector{Int64})::Int64 
    a10 = sum([1 for x in years if x <= 1900])
    a90 = sum([1 for x in years if x > 1910])
    
    if a10 > 3
        return 3
    elseif a90 > 3
        return 1
    else
        return 2
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate([1872, 1995, 1945]) == 2)
end
