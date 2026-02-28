function f(string::String)::String 
    if startswith(string, "Nuva")
        return rstrip(string)
    else
        return "no"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("Nuva?dlfuyjys") == "Nuva?dlfuyjys")
end
