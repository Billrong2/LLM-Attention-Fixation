function f(text::String)::String 
    ls = collect(text)
    for i in 1:length(ls)
        if ls[i] != '+'
            insert!(ls, i, '+')
            insert!(ls, i, '*')
            break
        end
    end
    return join(ls, '+')
end
using Test

@testset begin

candidate = f;
	@test(candidate("nzoh") == "*+++n+z+o+h")
end
