function f(text::String, char::String, min_count::Int64)::String 
    count = sum(string(i) == char for i in text)
    if count < min_count
        return uppercase(text) == text ? lowercase(text) : uppercase(text)
    else
        return text
    end
end


using Test

@testset begin

candidate = f;
	@test(candidate("wwwwhhhtttpp", "w", 3) == "wwwwhhhtttpp")
end
