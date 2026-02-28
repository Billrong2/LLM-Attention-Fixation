function f(text::String, position::Int64)::String 
    length_text = length(text)
    index = position % (length_text + 1)
    if position < 0 || index < 0
        index = -1
    end
    new_text = collect(text)
    deleteat!(new_text, index + 1)
    return join(new_text, "")
end

using Test

@testset begin

candidate = f;
	@test(candidate("undbs l", 1) == "udbs l")
end
