function f(s::String)::String 
    s = replace(s, "\"" => "")
    lst = collect(s)
    col = 1
    count = 1
    while col <= length(lst) && lst[col] in ['.', ':', ',']
        if lst[col] == '.'
            count = lst[col] + 1
        end
        col += 1
    end
    return join(lst[col+count:end], "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("\"Makers of a Statement\"") == "akers of a Statement")
end
