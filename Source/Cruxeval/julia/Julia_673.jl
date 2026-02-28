function f(string::String)::String 
    if all(isuppercase, string)
        return lowercase(string)
    elseif all(islowercase, string)
        return uppercase(string)
    end
    return string
end
using Test

@testset begin

candidate = f;
	@test(candidate("cA") == "cA")
end
