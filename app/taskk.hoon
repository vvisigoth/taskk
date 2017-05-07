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
::  ++  issue                                    ::
::      $:                                       ::
::        tit/@t                                ::
::        des/@t                                 ::
::        aut/@p                                 ::
::        :lin/purl                              ::
::        :ass/@p                                ::
::        pha/@tas                               ::
::      ==                                       ::
--                                               ::
!:                                               ::
|_  {hid/bowl state/$~}                          ::
++  poke-test                                    ::
  |=  $:
        boa/@t 
        tit/@t 
        des/@t 
        pha/phase
        aut/@p 
        ass/@p
      ==                                         ::
  =|  txt/@t
  ^-  {(list move) _+>.$}
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
--
