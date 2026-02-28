function f(text::String, ch::String)::Int64 
    return count(ch, text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("This be Pirate's Speak for 'help'!", " ") == 5)
end
