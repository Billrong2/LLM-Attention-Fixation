function f(items::String, target::String)::Union{Int64, String} 
    for (i, word) in enumerate(split(items))
        if occursin(word, target)
            return i + 1
        end
        
        if contains(word, ".") && (first(word) == '.' || last(word) == '.')
            return "error"
        end
    end
    return "."
end
using Test

@testset begin

candidate = f;
	@test(candidate("qy. dg. rnvprt rse.. irtwv tx..", "wtwdoacb") == "error")
end
