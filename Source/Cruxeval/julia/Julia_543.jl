function f(item::String)::String 
    modified = replace(item, ". " => " , ")
    modified = replace(modified, "&#33; " => "! ")
    modified = replace(modified, ". " => "? ")
    modified = replace(modified, ". " => ". ")
    return uppercase(modified[1]) * modified[2:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate(".,,,,,. منبت") == ".,,,,, , منبت")
end
