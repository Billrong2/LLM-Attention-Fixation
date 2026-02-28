function f(n::Int64)::String 
    p = ""
    if n % 2 == 1
        p *= "sn"
    else
        return string(n * n)
    end
    
    for x in 1:n
        if x % 2 == 0
            p *= "to"
        else
            p *= "ts"
        end
    end
    
    return p
end
using Test

@testset begin

candidate = f;
	@test(candidate(1) == "snts")
end
