function f(s::String)::String 
    d = rsplit(s, "ar"; limit=2)
    return join((d[1], "ar", d[2]), " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("xxxarmmarxx") == "xxxarmm ar xx")
end
