::  Accepts any noun from dojo and saves it in an md file
::
::::  
  ::  
  ::
  ::
  ::
/?    310
|%
  ++  card  {$info wire @p toro}                 :: card format for writing to clay
  ++  move  {bone card}                          ::
  ++  phase
      $?
        $todo
        $doin
        $show
        $done
      ==
--                                               ::
!:                                               ::
|_  {hid/bowl state/$~}                          ::
++  poke-css                                     ::
  |=  $:
        boa/@t                                   :: board name
        tit/@t                                   :: issue title
        des/@t                                   :: issue description
        pha/phase                                :: issue phase
        aut/@p                                   :: issue author
        ass/@p                                   :: issue assignee
      ==                                         
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
  :-
    [[ost.hid %info /writing our.hid (foal pax [%md !>(txt)])] ~] 
    +>.$
++  copy
  |=  {inp/path out/path}
  =|  cd/card
  ^-  {(list move) _+>.$}
  :: Maybe catch an error here
  =.  cd
    :*
      %info 
      /copying 
      our.hid 
      (foal out [%md !>(.^(* %cx inp))])
    ==
  [[[ost.hid cd] ~] +>.$]
:: Remove a file at a location
++  remove
  |=  inp/path
  =|  cad/card
  ^-  {(list move) _+>.$}
  :: Maybe catch an error here
  =.  cad
    :*
      %info 
      /removing 
      our.hid 
      (fray inp)
    ==
  [[[ost.hid cad] ~] +>.$]
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
