function f(text::String)::String 
    result = ""
    for i in reverse(1:length(text))
        result *= text[i]
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("was,") == ",saw")
end
