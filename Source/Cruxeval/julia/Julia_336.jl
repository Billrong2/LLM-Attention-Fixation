function f(s::String, sep::String)::String 
    s *= sep
    parts = split(s, sep)
    return join(parts[1:end-1], sep)
end
using Test

@testset begin

candidate = f;
	@test(candidate("234dsfssdfs333324314", "s") == "234dsfssdfs333324314")
end
