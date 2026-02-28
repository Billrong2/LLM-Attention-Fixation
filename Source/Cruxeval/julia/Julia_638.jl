function f(s::String, suffix::String)::String 
    if suffix == ""
        return s
    end
    
    while endswith(s, suffix)
        s = s[1:end-length(suffix)]
    end
    
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("ababa", "ab") == "ababa")
end
