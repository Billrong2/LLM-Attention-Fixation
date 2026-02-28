function f(text::String)::String 
    uppers = count(isuppercase, text)
    if uppers >= 10
        return uppercase(text)
    else
        return text
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("?XyZ") == "?XyZ")
end
