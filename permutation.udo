/*
PERMUTAZIONI LESSICOGRAFICHE
algorithm from:
https://www.quora.com/How-would-you-explain-an-algorithm-that-generates-permutations-using-lexicographic-ordering

1 - Find the largest x such that P[x]<P[x+1]. (If there is no such x, P is the last permutation.)
2 - Find the largest y such that P[x]<P[y].
3 - Swap P[x] and P[y].
4 - Reverse P[x+1 .. n].
*/

    opcode reverse_array, i[], i[]
iarr[] xin
ilen = lenarray(iarr)
iout_arr[] init ilen
ii = 0
while (ii < ilen) do
    iout_arr[ii] = iarr[(ilen - 1) - ii]
    ii += 1
od
xout(iout_arr)
    endop

    opcode factorial, i, i
ivalue xin

if(ivalue == 0 || ivalue == 1) then
    ifac = 1
else
    ifac = ivalue * factorial(ivalue - 1)
endif
xout(ifac)
    endop

    opcode concat, i[], i[]i[]
iarr1[], iarr2[] xin

ilen1 = lenarray(iarr1)
ilen2 = lenarray(iarr2)
ilen = ilen1 + ilen2

iarr[] init ilen

ii = 0
while (ii < ilen1) do
    iarr[ii] = iarr1[ii]
    ii += 1
od
while (ii < ilen) do
    iarr[ii] = iarr2[ii - ilen1]
    ik = ii
    ii += 1
od
xout(iarr)
    endop

    opcode bubbleSort, i[], i[] //O(N^2)
iarr[] xin

ii = 0
while (ii < lenarray(iarr) - 1) do
    ij = 0
    while (ij < lenarray(iarr) - 1) do
        if(iarr[ij] > iarr[ij + 1]) then
            itemp = iarr[ij]
            iarr[ij] = iarr[ij + 1]
            iarr[ij + 1] = itemp
        endif
        ij += 1
    od
    ii += 1
od

xout(iarr)
    endop

    opcode removeFromArray, i[], i[]i
iarr[], ielement xin

ilen = lenarray(iarr)
iout[] init ilen

iread = 0
iwrite = 0
while (iread < ilen) do
    ivalue = iarr[iread]
    if(ivalue != ielement) then
        iout[iwrite] = ivalue
        iwrite += 1
    endif
    iread += 1
od
trim_i(iout, iwrite)
xout(iout)
    endop

    opcode arpeggio, k, ki
kcount, ilen xin
if(kcount > ilen - 1) then
    kndx = ilen - (2 + (kcount%ilen))
    else
        kndx = kcount
    endif
xout(kndx)
    endop

    opcode lexiPerm, i[][], i[]
iarr[] xin

iarr[] = bubbleSort(iarr) //...prima di tutto ordiniamo l'array dal più piccolo al più grande
ilen = lenarray(iarr)
irow = factorial(ilen)
icol = ilen
iperm[][] init irow, icol

icount_row = 0
while (icount_row < irow) do

    ip = 0
    while (ip < ilen) do
        iperm[icount_row][ip] = iarr[ip]
        ip += 1
    od

    ilargest_x = -1
    ii = 0
    while (ii < ilen - 1) do
        if(iarr[ii] < iarr[ii + 1]) then
            ilargest_x = ii
        endif
        ii += 1
    od

    if(ilargest_x == -1) then
        goto break
    endif

    ilargest_y = -1
    ij = 0
    while (ij < ilen) do
        if(iarr[ilargest_x] < iarr[ij]) then
            ilargest_y = ij
        endif
        ij += 1
    od

    iarr[ilargest_x], iarr[ilargest_y] = iarr[ilargest_y], iarr[ilargest_x]
    iarr1[] = slicearray(iarr, 0, ilargest_x)
    iarr2[] = slicearray(iarr, ilargest_x + 1, ilen - 1)
    iarr2[] = reverse_array(iarr2)
    iarr[] = concat(iarr1, iarr2)

    icount_row += 1
od
break:
xout(iperm)
    endop
