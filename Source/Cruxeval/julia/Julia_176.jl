function f(text::String, to_place::String)::String 
    after_place = text[1:findfirst(to_place, text)[1]]
    before_place = text[findfirst(to_place, text)[1]+1:end]
    return after_place * before_place
end
using Test

@testset begin

candidate = f;
	@test(candidate("some text", "some") == "some text")
end
