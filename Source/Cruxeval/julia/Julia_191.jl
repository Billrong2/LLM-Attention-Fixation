function f(string::String)::Bool 
    if all(isuppercase, string)
        return true
    else
        return false
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("Ohno") == false)
end
