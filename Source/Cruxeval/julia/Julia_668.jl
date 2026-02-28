function f(text::String)::String 
    return text[end] * text[1:end-1]
end
using Test

@testset begin

candidate = f;
	@test(candidate("hellomyfriendear") == "rhellomyfriendea")
end
