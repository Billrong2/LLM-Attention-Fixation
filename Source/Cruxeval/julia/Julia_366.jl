function f(string::String)::String 
    tmp = lowercase(string)
    for char in lowercase(string)
        if char in tmp
            tmp = replace(tmp, char => ""; count=1)
        end
    end
    return tmp
end
using Test

@testset begin

candidate = f;
	@test(candidate("[ Hello ]+ Hello, World!!_ Hi") == "")
end
