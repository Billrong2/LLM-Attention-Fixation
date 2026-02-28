function f(text::String, digit::String)::Int64 
    count_digit = count(i -> string(i) == digit, text)
    return parse(Int64, digit) * count_digit
end
using Test

@testset begin

candidate = f;
	@test(candidate("7Ljnw4Lj", "7") == 7)
end
