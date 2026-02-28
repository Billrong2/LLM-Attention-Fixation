function f(text::String, value::String)::String 
    text_list = collect(text)
    append!(text_list, value)
    return join(text_list, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("bcksrut", "q") == "bcksrutq")
end
