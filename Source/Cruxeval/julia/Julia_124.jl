function f(txt::String, sep::String, sep_count::Int64)::String 
    o = ""
    while sep_count > 0 && count(txt, sep) > 0
        parts = split(txt, sep, limit=2)
        o *= parts[1] * sep
        txt = parts[2]
        sep_count -= 1
    end
    return o * txt
end
using Test

@testset begin

candidate = f;
	@test(candidate("i like you", " ", -1) == "i like you")
end
