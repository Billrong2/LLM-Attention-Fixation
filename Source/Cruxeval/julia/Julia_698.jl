function f(text::String)::String 
    return join([x for x in text if x != ')'], "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("(((((((((((d))))))))).))))(((((") == "(((((((((((d.(((((")
end
