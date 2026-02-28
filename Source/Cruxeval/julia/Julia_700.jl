function f(text::String)::Int64 
    return length(text) - count(occursin.("bot", text))
end
using Test

@testset begin

candidate = f;
	@test(candidate("Where is the bot in this world?") == 30)
end
