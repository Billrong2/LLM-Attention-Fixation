function f(text::String)::Bool 
    if text == "42.42"
        return true
    end
    
    for i in 3:length(text)-3
        if text[i] == '.' && isdigit(text[i-3:end]) && isdigit(text[1:i-1])
            return true
        end
    end
    
    return false
end
using Test

@testset begin

candidate = f;
	@test(candidate("123E-10") == false)
end
