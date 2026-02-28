function f(string::String)::String 
    return replace(string, "needles" => "haystacks")
end
using Test

@testset begin

candidate = f;
	@test(candidate("wdeejjjzsjsjjsxjjneddaddddddefsfd") == "wdeejjjzsjsjjsxjjneddaddddddefsfd")
end
