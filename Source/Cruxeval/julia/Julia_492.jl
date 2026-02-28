function f(text::String, value::String)::String 
    ls = collect(text)
    if count(e -> e == value, ls) % 2 == 0
        while value in ls
            deleteat!(ls, findfirst(x -> x == value, ls))
        end
    else
        empty!(ls)
    end
    return join(ls, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("abbkebaniuwurzvr", "m") == "abbkebaniuwurzvr")
end
