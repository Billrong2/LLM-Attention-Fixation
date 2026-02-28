function f(text::String, char::String)::String 
    text = collect(text)
    for (count, item) in enumerate(text)
        if item == char[1]
            deleteat!(text, count)
            return join(text, "")
        end
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("pn", "p") == "n")
end
