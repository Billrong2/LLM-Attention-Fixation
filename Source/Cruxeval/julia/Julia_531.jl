function f(text::String, x::String)::String 
    if startswith(text, x) == false
        return f(text[2:end], x)
    else
        return text
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("Ibaskdjgblw asdl ", "djgblw") == "djgblw asdl ")
end
