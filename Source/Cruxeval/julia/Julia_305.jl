function f(text::String, char::String)::String 
    length_text = length(text)
    index = -1
    for i in 1:length_text
        if text[i] == char[1]
            index = i
        end
    end
    if index == -1
        index = div(length_text, 2)
    end
    new_text = collect(text)
    deleteat!(new_text, index)
    return join(new_text, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("o horseto", "r") == "o hoseto")
end
