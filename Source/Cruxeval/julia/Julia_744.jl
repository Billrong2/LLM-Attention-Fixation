function f(text::String, new_ending::String)::String 
    result = collect(text)
    append!(result, new_ending)
    return join(result, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("jro", "wdlp") == "jrowdlp")
end
