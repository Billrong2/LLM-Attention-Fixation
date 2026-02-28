# 
sub f {
    my($text) = @_;
    my @nums = grep { $_ =~ /^\d+$/ } split('', $text);
    die "No numeric characters found" unless @nums;
    return join('', @nums);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("-123   	+314"),"123314")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
