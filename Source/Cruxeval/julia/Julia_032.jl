function f(s::String, sep::String)::String 
    reverse = ['*' * e for e in split(s, sep)]
    return join(reverse[end:-1:1], ';')
end
using Test

@testset begin

candidate = f;
	@test(candidate("volume", "l") == "*ume;*vo")
end
