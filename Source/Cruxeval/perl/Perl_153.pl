# 
sub f {
    my($text, $suffix, $num) = @_;
    my $str_num = "$num";
    return substr($text, -length $suffix - length $str_num) eq $suffix . $str_num;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("friends and love", "and", 3),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
