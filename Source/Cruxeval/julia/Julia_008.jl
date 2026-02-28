function f(string::String, encryption::Int64)::String 
    if encryption == 0
        return string
    else
        return uppercase(string)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("UppEr", 0) == "UppEr")
end
