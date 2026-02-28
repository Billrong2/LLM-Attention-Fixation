function f(text::String, length::Int64, index::Int64)::String 
    ls = split(text, ' ', limit=index)
    ls = reverse(ls)
    ls = [l[1:min(length, end)] for l in ls]
    return join(ls, "_")
end
using Test

@testset begin

candidate = f;
	@test(candidate("hypernimovichyp", 2, 2) == "hy")
end
