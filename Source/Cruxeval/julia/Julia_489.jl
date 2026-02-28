function f(text::String, value::String)::String 
    return replace(text, value => "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("coscifysu", "cos") == "cifysu")
end
