function f(text::String)::Bool 
    for i in ['.', '!', '?']
        if endswith(text, i)
            return true
        end
    end
    return false
end
using Test

@testset begin

candidate = f;
	@test(candidate(". C.") == true)
end
