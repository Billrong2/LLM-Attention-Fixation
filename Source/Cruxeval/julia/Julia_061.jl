function f(text::String)::String 
    texts = split(text)
    if !isempty(texts)
        xtexts = [t for t in texts if isascii(t) && !(t in ["nada", "0"])]
        return isempty(xtexts) ? "nada" : xtexts[indmax(length.(xtexts))]
    end
    return "nada"
end
using Test

@testset begin

candidate = f;
	@test(candidate("") == "nada")
end
