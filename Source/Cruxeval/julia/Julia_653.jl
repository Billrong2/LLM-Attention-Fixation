function f(text::String, letter::String)::Int64 
    t = text
    for alph in text
        t = replace(t, alph => "")
    end
    return length(split(t, letter))
end
using Test

@testset begin

candidate = f;
	@test(candidate("c, c, c ,c, c", "c") == 1)
end
