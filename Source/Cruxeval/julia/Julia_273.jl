function f(name::String)::String 
    new_name = ""
    name = reverse(name)
    for i in 1:length(name)
        n = name[i]
        if n != '.' && count(x->x=='.', new_name) < 2
            new_name = string(n, new_name)
        else
            break
        end
    end
    return new_name
end
using Test

@testset begin

candidate = f;
	@test(candidate(".NET") == "NET")
end
