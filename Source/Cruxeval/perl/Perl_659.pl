# 
sub f {
    my($bots) = @_;
    my @clean;
    foreach my $username (@{$bots}) {
        if ($username !~ /^[A-Z]+$/) {
            push @clean, substr($username, 0, 2) . substr($username, -3);
        }
    }
    return scalar @clean;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis"]),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
