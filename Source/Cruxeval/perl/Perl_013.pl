# 
sub f {
    my($names) = @_;
    my @names = @{$names};
    my $count = scalar @names;
    my $numberOfNames = 0;
    foreach my $name (@names) {
        if ($name =~ /^[a-zA-Z]+$/) {
            $numberOfNames++;
        }
    }
    return $numberOfNames;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["sharron", "Savannah", "Mike Cherokee"]),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
