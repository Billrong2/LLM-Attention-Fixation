function f(input::String)::Bool 
    for char in input
        if isuppercase(char)
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("a j c n x X k") == false)
end
