function f(text::String, letter::String)::Int64 
    counts = Dict{Char, Int}()
    for char in text
        if haskey(counts, char)
            counts[char] += 1
        else
            counts[char] = 1
        end
    end
    return get(counts, first(letter), 0)
end
using Test

@testset begin

candidate = f;
	@test(candidate("za1fd1as8f7afasdfam97adfa", "7") == 2)
end
