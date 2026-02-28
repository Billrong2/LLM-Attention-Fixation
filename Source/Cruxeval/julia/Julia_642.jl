function f(text::String)::String 
    i = 1
    while i <= length(text) && isspace(text[i])
        i += 1
    end
    if i > length(text)
        return "space"
    else
        return "no"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("     ") == "space")
end
