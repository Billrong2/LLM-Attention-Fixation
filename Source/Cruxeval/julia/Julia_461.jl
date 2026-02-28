function f(text::String, search::String)::Bool 
    return startswith(search, text) || false
end
using Test

@testset begin

candidate = f;
	@test(candidate("123", "123eenhas0") == true)
end
