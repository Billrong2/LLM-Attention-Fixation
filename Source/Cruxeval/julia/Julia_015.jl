function f(text::String, wrong::String, right::String)::String 
    new_text = replace(text, wrong => right)
    return uppercase(new_text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("zn kgd jw lnt", "h", "u") == "ZN KGD JW LNT")
end
