function f(text::String)::Int64 
    return length(split(text, '\n'))
end
using Test

@testset begin

candidate = f;
	@test(candidate("ncdsdfdaaa0a1cdscsk*XFd") == 1)
end
