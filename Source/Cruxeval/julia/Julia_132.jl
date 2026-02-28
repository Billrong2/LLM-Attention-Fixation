function f(a_str::String, prefix::String)::String 
    if !isempty(replace(a_str, prefix => "", count=1))
        return a_str
    else
        return prefix * a_str
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("abc", "abcd") == "abc")
end
