function f(text::String, suffix::String, num::Int64)::Bool 
    str_num = string(num)
    return endswith(text, suffix * str_num)
end
using Test

@testset begin

candidate = f;
	@test(candidate("friends and love", "and", 3) == false)
end
