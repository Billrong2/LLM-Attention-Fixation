# 
sub f {
    my($strings, $substr) = @_;
    my @list = grep { $_ =~ /^$substr/ } @{$strings};
    my @sorted_list = sort { length($a) <=> length($b) } @list;
    return \@sorted_list;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["condor", "eyes", "gay", "isa"], "d"),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
