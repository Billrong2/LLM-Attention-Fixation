function f(value::String)::String 
    parts = split(value, ' ')[1:2:end]
    return join(parts, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("coscifysu") == "coscifysu")
end
