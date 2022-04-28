!        This is file : test_loc
! Author= zaikunzhang
! Started at: 28.04.2022
! Last Modified: Friday, April 29, 2022 AM01:31:48
!
! NAG Fortran Compiler Release 7.0(Yurakucho) Build 7066 fails to compile this code with the
! following error message:
!
!```
!!$ nagfor test_loc.f90
!NAG Fortran Compiler Release 7.0(Yurakucho) Build 7066
![NAG Fortran Compiler normal termination]
!test_loc.f90: In function ‘test_loc_’:
!test_loc.f90:18:9: error: invalid operands to binary > (have ‘DDReal’ {aka ‘struct <anonymous>’} and ‘DDReal’ {aka ‘struct <anonymous>’})
!   18 | j = int(maxloc([A(1, i(1)), A(2, i(2)), A(3, i(3))], dim=1))
!      |         ^
!test_loc.f90:18:9: error: invalid operands to binary > (have ‘DDReal’ {aka ‘struct <anonymous>’} and ‘DDReal’ {aka ‘struct <anonymous>’})
!   18 | j = int(maxloc([A(1, i(1)), A(2, i(2)), A(3, i(3))], dim=1))
!```


program test_loc
use, intrinsic :: iso_fortran_env, only : RP => REAL128
implicit none
real(RP) :: A(3, 1)
integer :: i(3), j

A = 1.0_RP
i = [1, 1, 1]
j = int(maxloc([A(1, i(1)), A(2, i(2)), A(3, i(3))], dim=1))

write (*, *) j

end program test_loc
