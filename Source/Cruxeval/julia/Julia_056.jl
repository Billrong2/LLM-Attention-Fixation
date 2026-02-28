function f(sentence::String)::Bool 
    for c in sentence
        if isascii(c) == false
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("1z1z1") == true)
end
