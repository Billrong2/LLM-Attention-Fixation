function f(text::String, suffix::String)::String 
    if endswith(text, suffix)
        return text[1:endof(text)-length(suffix)]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("zejrohaj", "owc") == "zejrohaj")
end
