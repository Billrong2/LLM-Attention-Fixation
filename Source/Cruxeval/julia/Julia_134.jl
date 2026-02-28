function f(n::Int64)::String 
    t = 0
    b = ""
    digits = [parse(Int, x) for x in string(n)]
    
    for d in digits
        if d == 0
            t += 1
        else
            break
        end
    end
    
    for _ in 1:t
        b *= "1" * "0" * "4"
    end
    
    b *= string(n)
    return b
end
using Test

@testset begin

candidate = f;
	@test(candidate(372359) == "372359")
end
