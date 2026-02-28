function f(text::String)::String 
    ls = reverse(text)
    text2 = ""
    for i in length(ls)-2:-3:1
        text2 *= join(ls[i:i+2], "---") * "---"
    end
    return text2[1:end-3]
end
using Test

@testset begin

candidate = f;
	@test(candidate("scala") == "a---c---s")
end
