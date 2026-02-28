function f(text::String, char::String)::String 
    if text[end-length(char)+1:end] != char
        return f(char * text, char)
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("staovk", "k") == "staovk")
end
