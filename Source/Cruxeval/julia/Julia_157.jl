function f(phrase::String)::Int64 
    ans = 0
    words = split(phrase)
    for w in words
        for ch in w
            if ch == '0'
                ans += 1
            end
        end
    end
    return ans
end
using Test

@testset begin

candidate = f;
	@test(candidate("aboba 212 has 0 digits") == 1)
end
