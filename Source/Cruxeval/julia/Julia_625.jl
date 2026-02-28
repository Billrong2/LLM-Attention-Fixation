function f(text::String)::Int64 
    count = 0
    for i in text
        if i in ['.', '?', '!', ',']
            count += 1
        end
    end
    return count
end
using Test

@testset begin

candidate = f;
	@test(candidate("bwiajegrwjd??djoda,?") == 4)
end
