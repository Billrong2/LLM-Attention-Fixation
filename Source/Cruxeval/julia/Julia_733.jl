function f(text::String)::String
    len = div(length(text), 2)
    left_half = text[1:len]
    right_half = reverse(text[len+1:end])
    return left_half * right_half
end

using Test

@testset begin

candidate = f;
	@test(candidate("n") == "n")
end
