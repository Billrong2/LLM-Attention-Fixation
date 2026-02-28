function f(text::String)::String 
    result = Vector{Char}()
    for (i, ch) in enumerate(text)
        if ch == lowercase(ch)
            continue
        end
        if length(text) - 1 - i < findlast(c -> c == lowercase(ch), text)
            push!(result, ch)
        end
    end
    return join(result, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("ru") == "")
end
