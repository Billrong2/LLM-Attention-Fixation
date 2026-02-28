function f(text::String, prefix::String)::String 
    if startswith(text, prefix)
        return replace(text, prefix => "", limit=1)
    end    
    if occursin(prefix, text)
        return replace(text, prefix => "") |> strip
    end
    return uppercase(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("abixaaaily", "al") == "ABIXAAAILY")
end
