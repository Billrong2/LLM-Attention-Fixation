function f(text::String, chars::String)::String 
    result = collect(text)
    while chars in reverse(result[1:3])
        popfirst(result)
        popfirst(result)
    end
    return strip(join(result), '.')
end
using Test

@testset begin

candidate = f;
	@test(candidate("ellod!p.nkyp.exa.bi.y.hain", ".n.in.ha.y") == "ellod!p.nkyp.exa.bi.y.hain")
end
