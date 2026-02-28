function f(text::String)::String 
    words = split(text, ' ')
    for t in words
        if !all(isnumeric, t)
            return "no"
        end
    end
    return "yes"
end
using Test

@testset begin

candidate = f;
	@test(candidate("03625163633 d") == "no")
end
