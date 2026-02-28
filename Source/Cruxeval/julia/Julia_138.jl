function f(text::String, chars::String)::String 
    listchars = collect(chars)
    first = popfirst!(listchars)
    for i in listchars
        text = text[1:findfirst(i, text)] * i * text[findfirst(i, text)+1:end]
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("tflb omn rtt", "m") == "tflb omn rtt")
end
