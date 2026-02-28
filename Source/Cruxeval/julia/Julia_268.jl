function f(s::String, separator::String)::String
    for i in 1:length(s)
        if s[i] == separator[1]
            new_s = collect(s)
            new_s[i] = '/'
            return join(new_s, " ")
        end
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("h grateful k", " ") == "h / g r a t e f u l   k")
end
