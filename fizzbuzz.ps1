for ($fb=0; $fb -le 100; $fb++){
    if (( $fb % 3 -eq 0 ) -and ( $fb % 5 -eq 0)) {
        write-host -nonewline "$fb, Fizz" -fore Red;
        write-host "Buzz" -fore Yellow;
    }
    elseif ( $fb % 3 -eq 0 ) {
        write-host -fore Blue "$fb, Fizz";
    }
    elseif ( $fb % 5 -eq 0 ) {
        Write-Host -fore Green "$fb, Buzz";
    }
}