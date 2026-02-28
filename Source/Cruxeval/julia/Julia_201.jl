function f(text::String)::String 
    chars = []
    for c in text
        if isdigit(c)
            push!(chars, c)
        end
    end
    return join(reverse(chars))
end
using Test

@testset begin

candidate = f;
	@test(candidate("--4yrw 251-//4 6p") == "641524")
end
