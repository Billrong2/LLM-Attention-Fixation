function f(text::String)::String 
    if uppercase(text) == text
        return "ALL UPPERCASE"
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("Hello Is It MyClass") == "Hello Is It MyClass")
end
