function f(perc::String, full::String)::String 
    reply = ""
    i = 1
    while i <= min(length(perc), length(full)) && perc[i] == full[i]
        if perc[i] == full[i]
            reply *= "yes "
        else
            reply *= "no "
        end
        i += 1
    end
    return reply
end
using Test

@testset begin

candidate = f;
	@test(candidate("xabxfiwoexahxaxbxs", "xbabcabccb") == "yes ")
end
