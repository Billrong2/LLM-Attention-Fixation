function f(text::String, speaker::String)::String 
    while startswith(text, speaker)
        text = text[length(speaker)+1:end]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]", "[CHARRUNNERS]") == "Do you know who the other was? [NEGMENDS]")
end
