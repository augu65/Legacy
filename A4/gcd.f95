!By: Jonah Stegman
!Assignment 4
!CIS 3190
program gcd
    implicit none
    integer :: x, y, i, arr(3000)
    real :: time, dtime, t(2)
    character (len=25) :: fname
    ! Gets filename from the user
    write(*,*) "welcome to the GCD calclator"
    write(*,*) "This will calculate the gcd of a 3000 line file in 3 different ways"
    write(*,*)"All numbers must be on their own line"
    write(*,*)"calcuates using recursive, non-recursive euclid, and stein"
    write(*,fmt="(1x,a,i0)",advance="no")"Enter the filename: "
    read(*,*)fname
    ! reads in the file
    open (unit=1,file=fname,status='old',action='read')
    do i = 1, 3000
        read(1,*) arr(i)
    end do
    close (1)
    ! loops throught the array running the non recursive version of euclids gcd
    do i=1, 2999
        x = arr(i)
        y = arr(i+1)
        call eucluidNR_GCD(x,y)
    end do
    time = dtime(t)
    write(*,*)"Execution time of EuclidNR_GCD: ", time, "seconds"
    time = dtime(t)

    ! loops throught the array running the recursive version of euclids gcd
    do i=1, 2999
        x = arr(i)
        y = arr(i+1)
        call euclidR_GCD(x,y)
    end do
    time = dtime(t)
    write(*,*)"Execution time of EuclidR_GCD: ", time, "seconds"
    time = dtime(t)

    ! loops throught the array running the stein version of euclids gcd
    do i=1, 2999
        x = arr(i)
        y = arr(i+1)
        call stein_GCD(x,y)
    end do
    time = dtime(t)
    write(*,*)"Execution time of Stein_GCD: ", time, "seconds"
end program gcd

! the non recusive version of euclid gcd
subroutine eucluidNR_GCD(x,y)
    integer, intent(inout) :: x, y
    integer :: r
    ! ensures that y is valid
    if (y == 0) then 
        ! sets x to y as y is always the gcd
        y = x
        return
    end if
    ! calculates gcd
    r = mod(x,y)
    do
        if (r.eq.0) then
            exit
        end if
        x = y
        y = r
        r = mod(x,y)
    end do
    return
end subroutine eucluidNR_GCD

!The recusive version of euclid gcd
recursive subroutine euclidR_GCD(x,y)
    integer, intent(inout) :: x, y
    ! ensurs that y is valid
    if (y == 0) then
        ! sets to y as y is always the gcd
        y = x
        return
    else 
        ! recusivly calls to calculate gcd
        x = mod(x,y)
        call euclidR_GCD(y, x)
        return
    end if 
end subroutine euclidR_GCD

! the stein version of gcd
recursive subroutine stein_GCD(x,y)
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
            call stein_GCD(x, y)
            ! sets y to x as y is always the gcd
            y = x
            return 
        else ! both x and y are even
            x = rshift(x,1)
            y = rshift(y,1)
            call stein_GCD(x, y)
            y = ishft(x, 1)
            return 
        end if
    end if
    if (mod(y,2) == 0) then ! x is odd, y is even
        y = rshift(y,1)
        call stein_GCD(x, y)
        ! sets y to x as y is always the gcd
        y = x
        return 
    end if
    ! reduce larger parameter
    if (x > y) then
        x = rshift((x-y),1)
        call stein_GCD(x, y)
        ! sets y to x as y is always the gcd
        y = x 
        return 
    end if
    y = rshift((y-x),1)
    call stein_GCD(y, x)
    return 
end subroutine stein_GCD