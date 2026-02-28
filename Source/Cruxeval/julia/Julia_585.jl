function f(text::String)::String
    first_char = text[1]
    count_first_char = count(c -> c == first_char, text)
    ls = collect(text)
    for _ in 1:count_first_char
        deleteat!(ls, 1)
    end
    return join(ls)
end

using Test

@testset begin

candidate = f;
	@test(candidate(";,,,?") == ",,,?")
end
