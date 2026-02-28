function f(text::String, suffix::String)::String 
    if length(suffix) > 0 && endswith(text, suffix)
        return text[1:end-length(suffix)]
    end
    
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("mathematics", "example") == "mathematics")
end
