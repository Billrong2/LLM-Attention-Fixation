function f(integer::Int64, n::Int64)::String 
    i = 1
    text = string(integer)
    while i + length(text) < n
        i += length(text)
    end
    return string(integer, base=10, pad=i + length(text))
end
using Test

@testset begin

candidate = f;
	@test(candidate(8999, 2) == "08999")
end
