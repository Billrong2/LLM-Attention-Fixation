function f(text::String, limit::Int64, char::String)::String 
    if limit < length(text)
        return text[1:limit]
    end
    return lpad(text, limit, char)
end
using Test

@testset begin

candidate = f;
	@test(candidate("tqzym", 5, "c") == "tqzym")
end
