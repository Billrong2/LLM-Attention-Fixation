function f(text::String)::Bool 
    b = true
    for x in text
        if isdigit(x)
            b = true
        else
            b = false
            break
        end
    end
    return b
end
using Test

@testset begin

candidate = f;
	@test(candidate("-1-3") == false)
end
