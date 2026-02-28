function f(string::String)::String 
    while !isempty(string)
        if isletter(string[end])
            return string
        end
        string = string[1:end-1]
    end
    return string
end
using Test

@testset begin

candidate = f;
	@test(candidate("--4/0-209") == "")
end
