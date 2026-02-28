function f(num::Int64)::Union{String, Int64} 
    s = repeat("<", 10)
    if num % 2 == 0
        return s
    else
        return num - 1
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate(21) == 20)
end
