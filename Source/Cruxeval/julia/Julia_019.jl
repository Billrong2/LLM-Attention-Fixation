function f(x::String, y::String)::String 
    tmp = join([c == '9' ? '0' : '9' for c in reverse(y)], "")
    try
        x_parsed = parse(Int, x)
        tmp_parsed = parse(Int, tmp)
        return string(x_parsed * tmp_parsed)
    catch
        return x
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("", "sdasdnakjsda80") == "")
end
