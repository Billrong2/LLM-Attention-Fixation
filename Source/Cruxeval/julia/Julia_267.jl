function f(text::String, space::Int64)::String 
    if space < 0
        return text
    end
    return lpad(text, length(text) ÷ 2 + space)
end
using Test

@testset begin

candidate = f;
	@test(candidate("sowpf", -7) == "sowpf")
end
