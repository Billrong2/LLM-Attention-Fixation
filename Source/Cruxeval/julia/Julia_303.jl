function f(text::String)::String 
    i = cld(length(text) + 1, 2)
    result = collect(text)
    while i < length(text)
        t = lowercase(result[i])
        if t == result[i]
            i += 1
        else
            result[i] = t
        end
        i += 2
    end
    return join(result, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("mJkLbn") == "mJklbn")
end
