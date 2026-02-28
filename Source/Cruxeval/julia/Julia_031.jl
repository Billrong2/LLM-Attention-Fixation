function f(string::String)::Int64 
    upper = 0
    for c in string
        if isuppercase(c)
            upper += 1
        end
    end
    return upper * (upper % 2 == 0 ? 2 : 1)
end
using Test

@testset begin

candidate = f;
	@test(candidate("PoIOarTvpoead") == 8)
end
