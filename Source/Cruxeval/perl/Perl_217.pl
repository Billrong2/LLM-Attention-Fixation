# 
sub f {
    my($string) = @_;
    if ($string =~ /^[a-zA-Z0-9]+$/){
        return "ascii encoded is allowed for this language";
    }
    return "more than ASCII";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Str zahrnuje anglo-ameriæske vasi piscina and kuca!"),"more than ASCII")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
