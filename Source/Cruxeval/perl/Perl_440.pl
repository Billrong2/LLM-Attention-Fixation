# 
sub f {
    my($text) = @_;
    if ($text =~ /^\d+$/) {
        return 'yes';
    } else {
        return 'no';
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abc"),"no")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
