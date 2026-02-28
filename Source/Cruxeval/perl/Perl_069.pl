# 
sub f {
    my($student_marks, $name) = @_;
    if(exists $student_marks->{$name}) {
        my $value = delete $student_marks->{$name};
        return $value;
    }
    return 'Name unknown';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"882afmfp" => 56}, "6f53p"),"Name unknown")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
