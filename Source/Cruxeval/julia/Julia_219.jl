function f(s1::String, s2::String)::Bool 
    for k in 1:(length(s2) + length(s1))
        s1 *= s1[1]
        if occursin(s2, s1) 
            return true
        end
    end
    return false
end
using Test

@testset begin

candidate = f;
	@test(candidate("Hello", ")") == false)
end
