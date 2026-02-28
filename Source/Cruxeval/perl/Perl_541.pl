# 
sub f {
    my($text) = @_;
    my @new_text = split(//, $text);
    return join('', grep /\S/, @new_text) ne '';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(" 	  　"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
