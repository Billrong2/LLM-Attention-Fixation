function f(t::String)::Bool 
    for c in t
        if !isdigit(c)
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("#284376598") == false)
end
