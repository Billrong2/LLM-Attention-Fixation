function f(text::String)::Tuple{String, String} 
    parts = split(text, '|', limit=2)
    topic = length(parts) > 1 ? parts[1] : ""
    problem = length(parts) > 1 ? parts[2] : text
    if problem == "r"
        problem = replace(topic, "u" => "p")
    end
    return topic, problem
end

using Test

@testset begin

candidate = f;
	@test(candidate("|xduaisf") == ("", "xduaisf"))
end
