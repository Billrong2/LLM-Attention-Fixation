function f(text::String)::Int64 
    x = 0
    if all(islowercase, text)
        for c in text
            if parse(Int, c) in 0:89
                x += 1
            end
        end
    end
    return x
end
using Test

@testset begin

candidate = f;
	@test(candidate("591237865") == 0)
end
