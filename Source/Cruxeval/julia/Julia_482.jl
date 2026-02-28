function f(text::String)::String 
    return replace(text, "\\\"" => "\"")
end
using Test

@testset begin

candidate = f;
	@test(candidate("Because it intrigues them") == "Because it intrigues them")
end
