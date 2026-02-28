function f(n::String, m::String, text::String)::String 
    if strip(text) == ""
        return text
    end
    head, mid, tail = string(text[1]), text[2:end-1], string(text[end])
    joined = replace(head, n => m) * replace(mid, n => m) * replace(tail, n => m)
    return joined
end
using Test

@testset begin

candidate = f;
	@test(candidate("x", "\$", "2xz&5H3*1a@#a*1hris") == "2\$z&5H3*1a@#a*1hris")
end
