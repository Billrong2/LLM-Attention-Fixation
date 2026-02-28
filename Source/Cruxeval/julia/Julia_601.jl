function f(text::String)::String
    t = 5
    tab = []
    vowels = ['a', 'e', 'i', 'o', 'u', 'y']
    for i in text
        if lowercase(i) in vowels
            push!(tab, uppercase(i)^t)
        else
            push!(tab, i^t)
        end
    end
    return join(tab, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("csharp") == "ccccc sssss hhhhh AAAAA rrrrr ppppp")
end
