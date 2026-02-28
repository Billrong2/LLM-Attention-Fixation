function f(s::String, l::Int64)::String 
    return split(s * repeat("=", l), "=")[1]
end
using Test

@testset begin

candidate = f;
	@test(candidate("urecord", 8) == "urecord")
end
