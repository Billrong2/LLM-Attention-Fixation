function f(text::String, char::String)::String
    count = 0
    for i in 1:length(text)-1
        if text[i] == text[i+1] == char[1]
            count += 1
        end
    end
    return text[count+1:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("vzzv2sg", "z") == "zzv2sg")
end
