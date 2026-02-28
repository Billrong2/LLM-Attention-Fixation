function f(text::String, start::String)::Bool 
    return start == text[1:length(start)]
end
using Test

@testset begin

candidate = f;
	@test(candidate("Hello world", "Hello") == true)
end
