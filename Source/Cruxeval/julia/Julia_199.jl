function f(s::String, char::String)::String 
    base = repeat(char, count(s, char) + 1)
    return endswith(s, base) ? s[1:end-length(base)] : s
end
using Test

@testset begin

candidate = f;
	@test(candidate("mnmnj krupa...##!@#!@#\$\$@##", "@") == "mnmnj krupa...##!@#!@#\$\$@##")
end
