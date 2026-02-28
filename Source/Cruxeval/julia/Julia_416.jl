function f(text::String, old::String, new::String)::String
    result = collect(text)
    index = findlast(x -> x == old, text)
    while index != nothing
        result[index:index+length(old)] = collect(new)
        index = findlast(x -> x == old, text[1:index-1])
    end
    return join(result, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("jysrhfm ojwesf xgwwdyr dlrul ymba bpq", "j", "1") == "jysrhfm ojwesf xgwwdyr dlrul ymba bpq")
end
