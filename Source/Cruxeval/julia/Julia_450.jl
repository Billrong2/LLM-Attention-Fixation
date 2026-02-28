function f(strs::String)::String 
    strs = split(strs)
    for i in 2:2:length(strs)
        strs[i] = join(reverse(strs[i]))
    end
    return join(strs, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("K zBK") == "K KBz")
end
