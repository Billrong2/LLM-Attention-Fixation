function f(temp::Int64, timeLimit::Int64)::String 
    s = div(timeLimit, temp)
    e = rem(timeLimit, temp)
    return ifelse(s > 1, string(s, " ", e), string(e, " oC"))
end
using Test

@testset begin

candidate = f;
	@test(candidate(1, 1234567890) == "1234567890 0")
end
