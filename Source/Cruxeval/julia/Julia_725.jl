function f(text::String)::Int64 
    result_list = ['3', '3', '3', '3']
    if !isempty(result_list)
        empty!(result_list)
    end
    return length(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("mrq7y") == 5)
end
