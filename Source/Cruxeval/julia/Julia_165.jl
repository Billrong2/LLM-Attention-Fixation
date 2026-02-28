function f(text::String, lower::Int64, upper::Int64)::Bool 
    return isascii(text[lower:upper])
end
using Test

@testset begin

candidate = f;
	@test(candidate("=xtanp|sugv?z", 3, 6) == true)
end
