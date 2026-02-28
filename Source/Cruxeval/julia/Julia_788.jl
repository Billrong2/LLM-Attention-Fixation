function f(text::String, suffix::String)::String 
    if startswith(suffix, "/")
        return text * suffix[2:end]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("hello.txt", "/") == "hello.txt")
end
