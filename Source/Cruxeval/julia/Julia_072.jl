function f(text::String)::Bool 
    for c in text
        if !isdigit(c)
            return false
        end
    end
    return !isempty(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("99") == true)
end
