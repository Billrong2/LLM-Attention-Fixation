function f(x::String)::String 
    if all((islowercase(c) || c == ' ') for c in x)
        return x
    else
        return reverse(x)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("ykdfhp") == "ykdfhp")
end
