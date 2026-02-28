function f(text::String, value::String)::String
    length_ = length(text)
    index = 1
    while length_ > 0
        value = text[index] * value
        length_ -= 1
        index += 1
    end
    return value
end
using Test

@testset begin

candidate = f;
	@test(candidate("jao mt", "house") == "tm oajhouse")
end
