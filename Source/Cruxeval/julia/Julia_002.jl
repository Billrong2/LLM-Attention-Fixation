function f(text::String)::String 
    new_text = collect(text)
    for i in '+'
        if i in new_text
            filter!(x -> x != i, new_text)
        end
    end
    return join(new_text, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("hbtofdeiequ") == "hbtofdeiequ")
end
