function f(text::String, char::String)::Int64
    return findlast(char, text)[1] - 1
end

using Test

@testset begin

candidate = f;
	@test(candidate("breakfast", "e") == 2)
end
