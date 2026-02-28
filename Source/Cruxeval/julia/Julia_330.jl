function f(text::String)::String 
    ans = [isnumeric(ch) ? ch : ' ' for ch in text]
    return join(ans)
end
using Test

@testset begin

candidate = f;
	@test(candidate("m4n2o") == " 4 2 ")
end
