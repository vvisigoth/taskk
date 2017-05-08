::  Accepts any noun from dojo and saves it in an md file
::
::::  
  ::  
  ::
  ::
  ::
/?    310
/-  taskk-phase
|%
  ++  card  {$info wire @p toro}                 :: card format for writing to clay
  ++  move  {bone card}                          ::
--                                               ::
!:                                               ::
|_  {hid/bowl state/$~}                          ::
:: keep renaming this arms for testing, pay no heed
:: create a md file with the issue template
++  poke-taskk-issue                                   ::
  |=  {boa/@t tit/@t des/@t pha/taskk-phase aut/@p ass/@p}
  =|  {txt/@t ca/card}
  =+  pax=%/(scot %t boa)/(scot %t pha)/(scot %da now.hid)/md
  =.  txt
    %-  crip
    """
    ---
    author: {<aut>}
    assignee: {<ass>}
    ---
    #{(trip tit)}

    {(trip des)}
    """
  =.  ca
    :^
      %info
      /writing
      our.hid
      (foal pax [%md !>(txt)])
  [[[ost.hid ca] ~] +>.$]
::  move file 
::
++  poke-noun
  |=  {inp/path out/path}
  =|  car/card
  =.  car
    :^
      %info
      /moving
      our.hid
      %+  furl
        (fray inp)
        (foal out [%md !>(.^(* %cx inp))])
  [[[ost.hid car] ~] +>.$]
--
