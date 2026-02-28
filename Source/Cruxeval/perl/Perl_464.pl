# 
sub f {
    my($ans) = @_;
    if ($ans =~ /^\d+$/) {
        my $total = $ans * 4 - 50;
        my @non_even_digits = grep { $_ !~ /[02468]/ } split //, $ans;
        $total -= scalar @non_even_digits * 100;
        return $total;
    }
    return 'NAN';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("0"),-50)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
