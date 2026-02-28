# 
sub f {
    my($text) = @_;
    if (! $text =~ m/^\s*$/) {
        return length($text =~ s/^\s*//r =~ s/\s*$//r);
    }
    return undef;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(" 	 "),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
