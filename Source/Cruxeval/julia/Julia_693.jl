function f(text::String)::String 
    n = findfirst(isequal('8'), text)
    if n === nothing
        return ""
    else
        return "x0" ^ (n-1)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("sa832d83r xd 8g 26a81xdf") == "x0x0")
end
