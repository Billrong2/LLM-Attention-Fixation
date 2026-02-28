function f(text::String, old::String, new::String)::String 
    if length(old) > 3
        return text
    end
    
    if contains(text, old) && !occursin(" ", text)
        return replace(text, old => repeat(new, length(old)))
    end
    
    while contains(text, old)
        text = replace(text, old => new)
    end
    
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("avacado", "va", "-") == "a--cado")
end
