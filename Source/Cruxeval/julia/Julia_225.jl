function f(text::String)::Bool
    return all(islowercase(c) for c in text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("54882") == false)
end
