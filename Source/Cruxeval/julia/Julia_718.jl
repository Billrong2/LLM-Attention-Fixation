function f(text::String)::String 
    t = text
    for i in text
        text = replace(text, i => "")
    end
    return string(length(text), t)
end
using Test

@testset begin

candidate = f;
	@test(candidate("ThisIsSoAtrocious") == "0ThisIsSoAtrocious")
end
