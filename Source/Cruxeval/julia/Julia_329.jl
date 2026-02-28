function f(text::String)::Bool
    for i in 2:length(text)
        if text[i] == uppercase(text[i]) && text[i-1] == lowercase(text[i-1])
            return true
        end
    end
    return false
end
using Test

@testset begin

candidate = f;
	@test(candidate("jh54kkk6") == true)
end
