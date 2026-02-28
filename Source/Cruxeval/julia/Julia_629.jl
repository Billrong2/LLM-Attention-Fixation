function f(text::String, dng::String)::String 
    if !occursin(dng, text)
        return text
    end
    
    if endswith(text, dng)
        return text[1:end-length(dng)]
    end
    
    return text[1:end-1] * f(text[1:end-2], dng)
end
using Test

@testset begin

candidate = f;
	@test(candidate("catNG", "NG") == "cat")
end
