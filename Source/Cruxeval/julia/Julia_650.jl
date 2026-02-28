function f(string::String, substring::String)::String 
    while startswith(string, substring)
        string = string[length(substring)+1:end]
    end
    return string
end
using Test

@testset begin

candidate = f;
	@test(candidate("", "A") == "")
end
