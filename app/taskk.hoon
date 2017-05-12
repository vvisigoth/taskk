::
::
::
::::  
  ::  
  ::
  ::
  :: Front End Actions
  :: - Create issue
  :: - delete issue
  :: - edit issue body
  :: - edit issue phase
  :: - edit issue phase
  ::
/?    310
/-  taskk-phase
|%
  ++  card  
    $%  {$info wire @p toro}             
        {$diff mark *}
    ==
  ++  move  {bone card}                          ::
--                                               ::
!:                                               ::
|_  {hid/bowl state/$~}                          ::
:: create a md file with the issue template
++  poke-taskk-issue                             ::
  |= 
    $:
      boa/@t
      tit/@t
      des/@t
      pha/taskk-phase
      aut/@p
      ass/@p
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
  =.  ca
    :^
      %info
      /writing
      our.hid
      (foal pax [%md !>(txt)])
  [[[ost.hid ca] ~] +>.$]
::  move file 
::  used for changing board phase
++  poke-noun
  |=  {inp/path out/path}
  =|  ca/card
  =.  ca
    :^
      %info
      /moving
      our.hid
      %+  furl
        (fray inp)
        (foal out [%md !>(.^(* %cx inp))])
  [[[ost.hid ca] ~] +>.$]
:: useful for test
++  poke-path
  |=  inp/path
  ~&  [%path inp]
  ~&  [%crawled-path (crawl-path inp)]
  [[~] +>.$]
:: refactor this?
++  crawl-path
  |=  pax/path
  |-  ^-  json
  =+  a=.^(arch cy+pax)
  ?~  fil.a
    :-  %a
      %+  turn
        (sort (~(tap by dir.a)) aor)
        |=  {p/@t $~}
          [%a [[%s p] (crawl-path (welp pax /[p])) ~]]
  =+  txt=.^(@t cx+pax)
  [%s txt]
::  subscribe to taskk
++  peer-sub-path
  |=  arg/*
  =|  {jon/json pax/path}
  =.  pax  
    :: tried to use case 0, but didn't work?
    /==/(scot %da now.hid)/app/taskk/~~board     ::this should come from app
  =.  jon
    %+
      joba 
      'issues'
      (crawl-path pax)
  [[[ost.hid %diff %json jon] ~] +>.$]
--
