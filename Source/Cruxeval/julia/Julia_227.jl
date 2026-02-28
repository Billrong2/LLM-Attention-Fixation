function f(text::String)::String 
    text = lowercase(text)
    head, tail = text[1], text[2:end]
    return uppercase(head) * tail
end
using Test

@testset begin

candidate = f;
	@test(candidate("Manolo") == "Manolo")
end
