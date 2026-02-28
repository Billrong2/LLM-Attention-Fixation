function f(text::String)::String
    k, l = 1, lastindex(text)
    while !isletter(text[l])
        l -= 1
    end
    while !isletter(text[k])
        k += 1
    end
    if k != 1 || l != lastindex(text)
        return text[k:l]
    else
        return string(text[1])
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("timetable, 2mil") == "t")
end
