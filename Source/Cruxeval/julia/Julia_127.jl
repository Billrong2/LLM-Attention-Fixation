function f(text::String)::Int64 
    s = split(text, '\n')
    return length(s)
end
using Test

@testset begin

candidate = f;
	@test(candidate("145

12fjkjg") == 3)
end
