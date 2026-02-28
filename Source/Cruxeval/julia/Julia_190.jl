function f(text::String)::String 
    short = ""
    for c in text
        if islowercase(c)
            short *= c
        end
    end
    return short
end
using Test

@testset begin

candidate = f;
	@test(candidate("980jio80jic kld094398IIl ") == "jiojickldl")
end
