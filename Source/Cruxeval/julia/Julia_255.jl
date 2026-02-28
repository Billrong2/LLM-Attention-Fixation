function f(text::String, fill::String, size::Int64)::String 
    if size < 0
        size = abs(size)
    end
    if length(text) > size
        return text[end-size+1:end]
    else
        return string(fill^((size - length(text))) * text)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("no asw", "j", 1) == "w")
end
