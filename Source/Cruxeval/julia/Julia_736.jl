function f(text::String, insert::String)::String 
    whitespaces = Set(['\t', '\r', '\v', ' ', '\f', '\n'])
    clean = ""
    for char in text
        if char in whitespaces
            clean *= insert
        else
            clean *= char
        end
    end
    return clean
end
using Test

@testset begin

candidate = f;
	@test(candidate("pi wa", "chi") == "pichiwa")
end
