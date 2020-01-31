!gets a word from the user to encrypt
! w = word entered by the user
subroutine readWord(w)
implicit none
character (len=12) :: w
write(*,*) 'Please enter the word for Lucifer to encrypt:'
read(*,*) w
end
!converts the ASCII word to hexadecimal
!w = word, h = word in hex, l = length
subroutine word2hex(w,h,l)
implicit none
integer :: l
character (len=l) :: w
integer, dimension(1:127) :: h
character (len=2) :: hexTemp
integer :: i, j=1
do i=1,l
    write(hexTemp,'(Z2)') w(i:i)
    read(hexTemp(1:1),'(Z1)') h(j)
    j=j+1
    read(hexTemp(2:2),'(Z1)') h(j)
    j=j+1
end do
j=j-1
l=j
end
!prints out the word in hex
!h = the word in hex, l = length
subroutine printhex(h,l)
implicit none
integer :: l,i=1
integer, dimension(1:127) :: h
write(*,"(1x)", Advance = 'No')
do i=1, l
    if (h(i) == 10) write(*,"(A)", Advance = 'No' ) 'A'
    if (h(i) == 11) write(*,"(A)", Advance = 'No' ) 'B'
    if (h(i) == 12) write(*,"(A)", Advance = 'No' ) 'C'
    if (h(i) == 13) write(*,"(A)", Advance = 'No' ) 'D'
    if (h(i) == 14) write(*,"(A)", Advance = 'No' ) 'E'
    if (h(i) == 15) write(*,"(A)", Advance = 'No' ) 'F'
    if (h(i) < 10) write(*,"(32z1.1)", Advance = 'No') char(h(i))
end do
write(*,*)
end