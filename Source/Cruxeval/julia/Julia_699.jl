function f(text::String, elem::String)::Vector{String} 
    if elem != ""
        while startswith(text, elem)
            text = replace(text, elem, "")
        end
        while startswith(elem, text)
            elem = replace(elem, text, "")
        end
    end
    return [elem, text]
end
using Test

@testset begin

candidate = f;
	@test(candidate("some", "1") == ["1", "some"])
end
