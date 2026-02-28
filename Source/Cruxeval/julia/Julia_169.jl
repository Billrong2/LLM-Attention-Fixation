function f(text::String)::String 
    ls = collect(text)
    total = (length(text) - 1) * 2
    for i in 1:total
        if isodd(i)
            push!(ls, '+')
        else
            insert!(ls, 1, '+')
        end
    end
    return join(ls, "") |> x -> rpad(x, total)
end
using Test

@testset begin

candidate = f;
	@test(candidate("taole") == "++++taole++++")
end
