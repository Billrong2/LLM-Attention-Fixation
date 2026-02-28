function f(text::String, new_value::String, index::Int64)::String
    key = text[index+1]  # Adjust for 1-based indexing
    return replace(text, key => new_value)
end

using Test

@testset begin

candidate = f;
	@test(candidate("spain", "b", 4) == "spaib")
end
