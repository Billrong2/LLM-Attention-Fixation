function f(text::String, repl::String)::String 
    trans = Dict(zip(text, repl))
    return join([get(trans, c, c) for c in text])
end
using Test

@testset begin

candidate = f;
	@test(candidate("upper case", "lower case") == "lwwer case")
end
