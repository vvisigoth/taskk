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
++  poke-noun                                    ::
  |=  $:
        boar/@t 
        titl/@t 
        desc/@t 
        aut/@p 
        phas/@ud
      ==                                         ::
  =|  txt/@t
  ^-  {(list move) _+>.$}
  =+  pax=%/(scot %t boar)/(scot %ud phas)/(cat 3 (scot %da now.hid) '~')/md
  =.  txt
    %-  crip
    """
    ---
    author: {<aut>}
    ---
    #{(trip titl)}

    {(trip desc)}
    """
  [[[ost.hid %info /writing our.hid (foal pax [%md !>(txt)])] ~] +>.$]
--
