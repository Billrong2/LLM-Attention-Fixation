function f(places::Vector{Int64}, lazy::Vector{Int64})::Int64 
    sort!(places)
    for l in lazy
        deleteat!(places, findfirst(x -> x == l, places))
    end
    
    if length(places) == 1
        return 1
    end
    
    for i in 1:length(places)
        if count(x -> x == places[i] + 1, places) == 0
            return i
        end
    end
    
    return length(places)
end
using Test

@testset begin

candidate = f;
	@test(candidate([375, 564, 857, 90, 728, 92], [728]) == 1)
end
