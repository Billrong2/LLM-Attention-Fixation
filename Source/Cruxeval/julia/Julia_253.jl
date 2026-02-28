function f(text::String, pref::String)::String 
    if pref == text[1:length(pref)]
        return text[length(pref)+1:end]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("kumwwfv", "k") == "umwwfv")
end
