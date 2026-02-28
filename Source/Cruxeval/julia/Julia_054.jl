function f(text::String, s::Int64, e::Int64)::Int64
    sublist = text[s+1:e]  # Julia uses 1-based indexing, so adjust the start index
    if isempty(sublist)
        return -1
    end
    min_char = minimum(sublist)
    return findfirst(==(min_char), sublist) - 1  # Adjust for 0-based index in the result
end

using Test

@testset begin

candidate = f;
	@test(candidate("happy", 0, 3) == 1)
end
