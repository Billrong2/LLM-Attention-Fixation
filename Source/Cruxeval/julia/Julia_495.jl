function f(s::String)::Tuple{String, String} 
    if all(isascii, s[end-4:end])
        return s[end-4:end], s[1:3]
    elseif all(isascii, s[1:5])
        return s[1:5], s[end-2:end]
    else
        return s
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("a1234år") == ("a1234", "år"))
end
