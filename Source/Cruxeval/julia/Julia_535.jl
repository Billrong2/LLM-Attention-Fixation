function f(n::Int64)::Bool 
    for i in string(n)
        if !(i in ['0','1','2']) && !(i in ['5','6','7','8','9'])
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate(1341240312) == false)
end
