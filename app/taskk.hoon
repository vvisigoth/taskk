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
  =+  pax=%/(scot %t boar)/(scot %ud phas)/(cat 3 (scot %da now.hid) '~')/md
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
  [[[ost.hid %info /writing our.hid (foal pax [%md !>(txt)])] ~] +>.$]
:: not tested yet, put in test logic.
++  poke-noun
  |=  {inp/path out/path}
  ^-  {(list move) _+>.$}
  :: Maybe catch an error here
  =+  cd=[%info /writing our.hid (foal out [%md !>(.^(* %cx inp))])]
  [[[ost.hid cd] ~] +>.$]
--
