function f(text::String, char::String)::Bool 
    return count(occ -> occ == char, text) % 2 != 0
end
using Test

@testset begin

candidate = f;
	@test(candidate("abababac", "a") == false)
end
