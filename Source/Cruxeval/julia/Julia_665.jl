function f(chars::String)::String 
    s = ""
    for ch in chars
        if count(x -> x == ch, chars) % 2 == 0
            s *= uppercase(ch)
        else
            s *= ch
        end
    end
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("acbced") == "aCbCed")
end
