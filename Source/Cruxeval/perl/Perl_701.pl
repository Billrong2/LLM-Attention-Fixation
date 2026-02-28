# 
sub f {
    my($stg, $tabs) = @_;
    foreach my $tab (@$tabs) {
        $stg =~ s/$tab$//g;
    }
    return $stg;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("31849 let it!31849 pass!", ["3", "1", "8", " ", "1", "9", "2", "d"]),"31849 let it!31849 pass!")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
