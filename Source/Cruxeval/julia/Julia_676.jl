function f(text::String, tab_size::Int64)::String 
    return replace(text, '\t' => repeat(' ', tab_size))
end
using Test

@testset begin

candidate = f;
	@test(candidate("a", 100) == "a")
end
