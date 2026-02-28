function f(text::String)::Bool 
    return isascii(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("wW의IV]HDJjhgK[dGIUlVO@Ess\$coZkBqu[Ct") == false)
end
