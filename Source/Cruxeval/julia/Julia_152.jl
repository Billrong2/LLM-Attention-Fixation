function f(text::String)::Int64
    n = 0
    for char in text
        if isuppercase(char)
            n += 1
        end
    end
    return n
end
using Test

@testset begin

candidate = f;
	@test(candidate("AAAAAAAAAAAAAAAAAAAA") == 20)
end
