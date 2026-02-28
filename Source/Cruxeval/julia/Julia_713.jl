function f(text::String, char::String)::Bool 
    if occursin(char, text)
        text = [strip(t) for t in split(text, char) if t != ""]
        if length(text) > 1
            return true
        end
    end
    return false
end
using Test

@testset begin

candidate = f;
	@test(candidate("only one line", " ") == true)
end
