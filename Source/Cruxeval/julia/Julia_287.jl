function f(name::String)::String 
    if all(islowercase, name)
        name = uppercase(name)
    else
        name = lowercase(name)
    end
    return name
end
using Test

@testset begin

candidate = f;
	@test(candidate("Pinneaple") == "pinneaple")
end
