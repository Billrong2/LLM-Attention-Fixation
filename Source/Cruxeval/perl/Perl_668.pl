# 
sub f {
    my($text) = @_;
    return substr($text, -1) . substr($text, 0, length($text)-1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hellomyfriendear"),"rhellomyfriendea")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
