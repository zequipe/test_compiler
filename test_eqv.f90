!        This is file : test
! Author= zaikunzhang
! Started at: 07.09.2023
! Last Modified: Sunday, September 17, 2023 PM03:07:45

program test_eqv
implicit none
real :: x, y
character(len=100) :: str
x = huge(x)
x = x**2 / x**3     ! Evaluates to NaN. Intended.
write (str, *) x
read (str, *) y
write (*, *) x, y, str
write (*, *) 'x <= 0.0, y <= 0.0', ', (x <= 0.0 .eqv. y <= 0.0)', ', (x <= 0.0 .neqv. y <= 0.0)'
write (*, *) x <= 0.0, y <= 0.0, (x <= 0.0 .eqv. y <= 0.0), (x <= 0.0 .neqv. y <= 0.0)

if (x <= 0.0 .eqv. y <= 0.0) then
    write (*, *) 'Right.'
else
    write (*, *) 'Wrong!'
    stop 1
end if

end program test_eqv
