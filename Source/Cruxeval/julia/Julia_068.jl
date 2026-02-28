function f(text::String, pref::String)::String 
    if startswith(text, pref)
        n = length(pref)
        suffix = split(text[n+1:end], '.')[2:end]
        prefix = split(text[1:n-1], '.')[1:end-1]
        text = join([suffix; prefix], '.')
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("omeunhwpvr.dq", "omeunh") == "dq")
end
