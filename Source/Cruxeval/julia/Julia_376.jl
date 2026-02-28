function f(text::String)::String 
    for i in 1:length(text)
        if startswith(text[1:i], "two")
            return text[i+1:end]
        end
    end
    return "no"
end
using Test

@testset begin

candidate = f;
	@test(candidate("2two programmers") == "no")
end
