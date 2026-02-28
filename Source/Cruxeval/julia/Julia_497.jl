function f(n::Int64)::Vector{String} 
    b = [string(d) for d in digits(n)]
    for i in 3:length(b)
        b[i] *= "+"
    end
    return b
end
using Test

@testset begin

candidate = f;
	@test(candidate(44) == ["4", "4"])
end
