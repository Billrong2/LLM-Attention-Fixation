function f(s::String)::Int64
    for i in 1:length(s)
        if isdigit(s[i])
            return i - 1 + (s[i] == '0' ? 1 : 0)
        elseif s[i] == '0'
            return -1
        end
    end
    return -1
end

using Test

@testset begin

candidate = f;
	@test(candidate("11") == 0)
end
