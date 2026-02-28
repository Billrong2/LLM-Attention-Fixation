function f(text::String, sub::String)::Int64
    a = 0
    b = length(text) - 1

    while a <= b
        c = div(a + b, 2)
        if findlast(sub, text) !== nothing && findlast(sub, text) >= c
            a = c + 1
        else
            b = c - 1
        end
    end

    return a
end

using Test

@testset begin

candidate = f;
	@test(candidate("dorfunctions", "2") == 0)
end
