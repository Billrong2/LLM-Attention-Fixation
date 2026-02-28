function f(st::String)::String
    lower_st = lowercase(st)
    last_h_index = findlast('h', lower_st)
    last_i_index = findlast('i', lower_st)
    if last_h_index != nothing && last_i_index != nothing && last_h_index >= last_i_index
        return "Hey"
    else
        return "Hi"
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("Hi there") == "Hey")
end
