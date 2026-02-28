function f(text::String, symbols::String)::String 
    count = 0
    if !isempty(symbols)
        count = length(symbols)
        text = text^count
    end
    return rpad(text, length(text) + count*2)[1:(end - 2)]
end
using Test

@testset begin

candidate = f;
	@test(candidate("", "BC1ty") == "        ")
end
