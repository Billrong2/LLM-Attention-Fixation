function f(text::String, position::Int64, value::String)::String
    length_text = length(text)
    index = (position % (length_text + 2)) - 1
    if index >= length_text || index < 0
        return text
    else
        text = collect(text)
        text[index+1] = value[1]
        return join(text)
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("1zd", 0, "m") == "1zd")
end
