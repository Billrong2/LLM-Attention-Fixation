function f(text::String)::Int64
    s = 0
    for i in 1:length(text)-1
        s += length(split(text, text[i+1:end])[1])
    end
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate("wdj") == 3)
end
