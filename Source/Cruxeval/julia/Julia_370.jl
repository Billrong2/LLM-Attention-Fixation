function f(text::String)::Bool 
    for char in text
        if !isspace(char)
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("     i") == false)
end
