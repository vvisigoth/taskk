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
  =|  jon/json
  =.  jon
    %+  joba
    'board'
    (crawl-path inp)
  [[[ost.hid %diff %json jon] ~] +>.$]
::
++  create-path
::
  |=  {host/@t board/@t phase/(unit @t) issue/(unit @t)}
  :: there's no circumstance where there's an issue w/out phase, so maybe make these one 
  :: data structure? phiss?
  ^-  path
  ?~  phase
    /(scot %tas host)/home/(scot %da now.hid)/app/taskk/(scot %tas board)
  /(scot %tas host)/home/(scot %da now.hid)/app/taskk/(scot %tas board)/(scot %tas (need phase))/(scot %tas (need issue))/md
::
++  poke-json
  |=  jin/json
  ^-  (quip move +>.$)
  ?.  ?=($o -.jin)
    [[[ost.hid %diff %json ~] ~] +>.$]
  :: map this whole thing
  =/  h  (~(got by p.jin) 'host')
  =/  b  (~(got by p.jin) 'board')
  =/  i  (~(got by p.jin) 'issue')
  =/  ph  (~(got by p.jin) 'phase')
  =/  hi  ?:  ?=($s -.h)  p.h  ~
  =/  bi  ?:  ?=($s -.b)  p.b  ~
  =/  ii  ?:  ?=($s -.i)  p.i  ~
  =/  phi  ?:  ?=($s -.ph)  p.ph  ~
  ::=/  pax  (create-path [`@t`hi `@t`bi [~ `@t`phi] [~ `@t`ii]])
  =/  pax  (create-path [`@t`hi `@t`bi ~ ~])
  ~&  pax
  =/  jout  (crawl-path pax)
  :_  +>.$
  %+  turn  (prey /sub-path hid)
    |=  {o/bone *}
    [o %diff %json jout]
::
::
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
