! This program takes a message and key and encrypts it
! using the lucifer encryption algorithm
program luchex
implicit none
integer, dimension(0:7,0:15) :: k
integer, dimension(0:7,0:7,0:1) :: m
integer, dimension(0:127) :: key,message
integer, dimension(0:31) :: kb,hex
integer :: i,l
real ::  d=0
character (len=12) :: w
equivalence (k(0,0),key(1)),(m(0,0,0),message(1))
write(*,*) 'Welcome to Lucifer!'
write(*,*) 'Encrypt a message using the lucifer algorthm.'
!get input
write(*,*) 'Please enter the key for Lucifer:'
read(*,"(32z1.1)") (kb(i),i=0,31)

!run functions from hex.f95
call readWord(w)
l = len(trim(w))
call word2hex(w,hex,l)
write(*,*) 'inputed word as hex:'
call printhex(hex,l)

call expand(message,hex,32)
call expand(key,kb,32)

call lucifer(d,k,m)
!get ciphertext and print it
call compress(message,hex,32)
write(*,*)'String as cipher text'
write(*,"(1x,32z1.1)") (hex(i),i=0,31)
!sets lucifer to decrypt mode
d=1
call lucifer(d,k,m)
!gets decrypted key and message and prints it
call compress(message,hex,32)
call compress(key,kb,32)
write(*,*) 'Lucifer key'
write(*,"(1x,32z1.1)") (kb(i),i=0,31)
write(*,*) 'Decoded string'
call printhex(hex,l)

end program luchex

!This function encrypt or decrypts a message
!This is based on the value of d with k being
!the key and m being the message 
subroutine lucifer(d,k,m)
implicit none
integer, dimension(0:7,0:7,0:1) :: m
integer, dimension(0:7,0:15) :: k
integer, dimension(0:1) :: c
integer, dimension (0:7,0:7) :: sw
!     inverse of fixed permutation
integer, dimension(0:7) :: pr=[2,5,4,0,3,1,7,6]
integer, dimension(0:7) :: tr 
!     diffusion pattern
integer, dimension(0:7) :: o=[7,6,2,1,5,0,3,4]
!     S-box permutations
integer, dimension(0:15) :: s0=[12,15,7,10,14,13,11,0,2,6,3,1,9,4,5,8]
integer, dimension(0:15) :: s1=[7,2,14,9,3,11,0,4,12,13,1,10,6,15,8,5]
integer :: h0=0, kc=0, ii, h1=1, ks, jj, jjj, l, h, v, kk
real :: d
equivalence (c(0),h),(c(1),l)

if (d .eq. 1) kc=8

do ii=1,16,1

    if (d.eq.1) kc=mod(kc+1,16)
    ks=kc

    do jj=0,7,1
    l=0
    h=0

        do kk=0,3,1
            l=l*2+m(7-kk,jj,h1)
        end do
        do kk=4,7,1
        h=h*2+m(7-kk,jj,h1)
        end do

        v=(s0(l)+16*s1(h))*(1-k(jj,ks))+(s0(h)+16*s1(l))*k(jj,ks)

        do kk=0,7,1
            tr(kk)=mod(v,2)
            v=v/2
        end do

        do kk=0,7,1
            m(kk,mod(o(kk)+jj,8),h0)=mod(k(pr(kk),kc)+tr(pr(kk))&
            + m(kk,mod(o(kk)+jj,8),h0),2)
        end do
        if (jj .lt. 7 .or. d .eq. 1) kc=mod(kc+1,16)
    end do

    jjj=h0
    h0=h1
    h1=jjj
end do

do jj=0,7,1
    do kk=0,7,1
        sw(kk,jj)=m(kk,jj,0)
        m(kk,jj,0)=m(kk,jj,1)
        m(kk,jj,1)=sw(kk,jj)
    end do
end do

return
end

!this function expands a byte b into an array
!l is the length of the array
subroutine expand(a,b,l)
implicit none
integer, dimension(0:*) :: a, b
integer :: i, j, v, l

do i=0,l-1,1
    v=b(i)
    do j=0,3,1
        a((3-j)+i*4)=mod(v,2)
        v=v/2
    end do
end do
return
end

!this function compresses an array a back to byte for in b
! l is the lenght of the array
subroutine compress(a,b,l)
implicit none
integer, dimension(0:*) :: a, b
integer :: i, j, v, l

do i=0,l-1,1
    v=0
    do j=0,3,1
        v=v*2+mod(a(j+i*4),2)
    end do
    b(i)=v
end do
return
end
