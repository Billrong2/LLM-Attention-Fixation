function f(text::String, n::Int64)::String 
    if n < 0 || length(text) <= n
        return text
    end
    
    result = text[1:n]
    i = length(result)
    while i >= 1
        if result[i] != text[i]
            break
        end
        i -= 1
    end
    
    return text[1:i]
end
using Test

@testset begin

candidate = f;
	@test(candidate("bR", -1) == "bR")
end
