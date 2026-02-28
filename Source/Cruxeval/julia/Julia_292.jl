function f(text::String)::String 
    new_text = [isnumeric(c) ? c : '*' for c in text]
    return join(new_text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("5f83u23saa") == "5*83*23***")
end
