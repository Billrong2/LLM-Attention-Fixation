function f(text::String, char::String)::Vector{Int64} 
    new_text = text
    a = Int64[]
    while contains(new_text, char)
        push!(a, findfirst(x -> x == char[1], new_text) - 1)
        new_text = replace(new_text, char => "" ,count=1)
    end
    return a
end

using Test

@testset begin

candidate = f;
	@test(candidate("rvr", "r") == [0, 1])
end
