function f(text::String)::String
    if isempty(text) 
        return "string" 
    end
    if all(isdigit(c) for c in text)
        return "integer"
    else
        return "string"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("") == "string")
end
