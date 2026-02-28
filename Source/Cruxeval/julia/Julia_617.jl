function f(text::String)::String 
    if isascii(text)
        return "ascii"
    else
        return "non ascii"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("<<<<") == "ascii")
end
