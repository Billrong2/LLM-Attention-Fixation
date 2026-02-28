function f(text::String, chars::String)::String
    num_applies = 2
    extra_chars = ""
    for i in 1:num_applies
        extra_chars *= chars
        text = replace(text, extra_chars => "")
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("zbzquiuqnmfkx", "mk") == "zbzquiuqnmfkx")
end
