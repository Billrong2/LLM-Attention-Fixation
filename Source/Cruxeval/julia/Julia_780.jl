function f(ints::Vector{Int64})::String 
    counts = zeros(Int64, 301)
    
    for i in ints
        counts[i + 1] += 1
    end
    
    r = []
    for i in 1:length(counts)
        if counts[i] >= 3
            push!(r, string(i - 1))
        end
    end
    
    return join(r, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 3, 5, 2, 4, 5, 2, 89]) == "2")
end
