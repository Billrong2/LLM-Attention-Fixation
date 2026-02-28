function f(text::String)::Int64 
    m = 0
    cnt = 0
    for i in split(text)
        if length(i) > m
            cnt += 1
            m = length(i)
        end
    end
    return cnt
end
using Test

@testset begin

candidate = f;
	@test(candidate("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl") == 2)
end
