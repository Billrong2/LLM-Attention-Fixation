function f(text::String, chars::String)::String
    if !isempty(chars)
        text = rstrip(text, Set(chars))
    else
        text = rstrip(text, ' ')
    end
    if text == ""
        return "-"
    end
    return text
end

using Test

@testset begin

candidate = f;
	@test(candidate("new-medium-performing-application - XQuery 2.2", "0123456789-") == "new-medium-performing-application - XQuery 2.")
end
