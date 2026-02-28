function f(string::String)::String 
    return replace(titlecase(string), " " => "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("1oE-err bzz-bmm") == "1Oe-ErrBzz-Bmm")
end
