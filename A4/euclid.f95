!By: Jonah Stegman
!Assignment 4
!CIS 3190
program euclid
    implicit none
    integer :: x, y
    x = 0
    y = 137
    call gcd(x,y)
    write(*,"(I10)") y
    x = 0
    y = 137
    call recursive_gcd(x,y)
    write(*,"(I10)") y
    x = 0
    y = 137
    call stein_gcd(x,y)
    write(*,"(I10)") y
end program euclid

subroutine gcd(x,y)
    integer, intent(inout) :: x, y
    integer :: r
    if (y == 0) then 
        y = x
        return
    end if
    r = mod(x,y)
    do k=0,1000000,1
        if (r.eq.0) then
            exit
        end if
        x = y
        y = r
        r = mod(x,y)
    end do
    return
end subroutine gcd

recursive subroutine recursive_gcd(x,y)
    integer, intent(inout) :: x, y
    if (y == 0) then
        y = x
        return
    else 
        x = mod(x,y)
        call recursive_gcd(y, x)
        return
    end if 
end subroutine recursive_gcd


recursive subroutine stein_gcd(x,y)
    integer, intent(inout) :: x, y
    if (x == y .OR. y == 0) then
        y = x
        return
    else if (x == 0) then
        return
    end if 
    if (mod(x,2) == 0) then ! x is even
        if (mod(y,2)/=0) then ! y is odd
            x = rshift(x,1)
            call stein_gcd(x, y)
            y = x
            return 
        else ! both x and y are even
            x = rshift(x,1)
            y = rshift(y,1)
            call stein_gcd(x, y)
            y = ishft(x, 1)
            return 
        end if
    end if
    if (mod(y,2) == 0) then ! x is odd, y is even
        y = rshift(y,1)
        call stein_gcd(x, y)
        y = x
        return 
    end if
    ! reduce larger parameter
    if (x > y) then
        x = rshift((x-y),1)
        call stein_gcd(x, y)
        y = x 
        return 
    end if
    y = rshift((y-x),1)
    call stein_gcd(y, x)
    return 
end subroutine stein_gcd