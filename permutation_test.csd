<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>


sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


#include "permutation.udo"

seed(0)

  instr 1
iseq[] = fillarray(60, 62, 36, 66, 67, 48, 55, 72)
idur_note = 1/5
iadd = 0.00707
idur[] = fillarray(idur_note, idur_note + iadd, idur_note + (iadd * 2), idur_note + (iadd * 3), idur_note + (iadd * 4), idur_note + (iadd * 5), idur_note + (iadd * 6), 1/4)

print(lenarray(idur))
ipermNote[][] lexiPerm iseq // generate n! permutation
ipermDur[][] lexiPerm idur // generate n! permutation
indxNote[] = genarray(0, lenarray(ipermNote) - 1)
indxDur[] = genarray(0, lenarray(ipermDur) - 1)

ilen_limit = lenarray(iseq) - 2 // limite indice per arpeggio
ilen = lenarray(iseq)
kp2 init 0
kcount_choose init 0 // contiamo il numero di scelte
krow_note init 0
krow_dur init 0
kt init 0
kndx init 0
if((metro(1/0.01) == 1 && kt < ilen_limit)) then
  event("i", "perm_test", kp2, ipermDur[krow_dur][kndx] * random:k(1.5, 6), ipermNote[krow_note][kndx])

  kterm = random:k(0.0, 1.0)
  if(kterm < 0.05) then
    krnd_dur = 5
    else
      krnd_dur = random:k(0.81, 1)
    endif

  kp2 += ipermDur[krow_dur][kndx] * krnd_dur
  kt += 1
  kndx = arpeggio(kt, ilen)

  if(kt >= ilen_limit) then
    if(kcount_choose < lenarray(ipermNote)) then
      krow_note = indxNote[random:k(0, lenarray(ipermNote) - 1)]
      krow_dur = indxDur[random:k(0, lenarray(ipermDur) - 1)]
      indxNote[] = removeFromArray(indxNote, i(krow_note))
      indxDur[] = removeFromArray(indxDur, i(krow_dur))
      kcount_choose += 1
      else
        goto break
      endif
      kt = 0
    endif

endif

break:
  endin


  instr perm_test
a1 = poscil(linseg:a(0, .001, 1/5, p3 - .001, 0), cpsmidinn(p4))
outs(a1, a1)
  endin



</CsInstruments>
<CsScore>

i 1 0 30

</CsScore>
</CsoundSynthesizer>
