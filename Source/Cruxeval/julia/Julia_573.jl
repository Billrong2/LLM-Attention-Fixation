function f(string::String, prefix::String)::String 
    if startswith(string, prefix)
        return replace(string, prefix => "", count=1)
    end
    return string
end
using Test

@testset begin

candidate = f;
	@test(candidate("Vipra", "via") == "Vipra")
end
