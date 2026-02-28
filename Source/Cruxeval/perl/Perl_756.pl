# 
sub f {
    my($text) = @_;
    if ($text =~ /^[0-9]+$/) {
        return 'integer';
    }
    return 'string';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(""),"string")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
