function f(text::String)::String 
    punctuations = ['!', '.', '?', ',', ':', ';']
    for punct in punctuations
        if count(punct, text) > 1
            return "no"
        end
        if endswith(text, punct)
            return "no"
        end
    end
    return titlecase(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("djhasghasgdha") == "Djhasghasgdha")
end
