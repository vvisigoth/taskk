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
::  write json
++  create-issue
  :: take json from request
  |=  jon/json
  ^-  (list move)
  =|  {pax/path ca/card}
  ?.  ?=($o -.jon)
    :: TODO return an error instead 
    [[ost.hid %diff %json ~] ~]
    ::
  =/  ho  (~(got by p.jon) 'host')
  =/  hos  ?:  ?=($s -.ho)  p.ho  ~
  =/  bo  (~(got by p.jon) 'board')
  =/  boa  ?:  ?=($s -.bo)  p.bo  ~
  =/  ph  (~(got by p.jon) 'phase')
  =/  pha  ?:  ?=($s -.ph)  p.ph  ~
  =/  ti  (~(got by p.jon) 'title')
  =/  tit  ?:  ?=($s -.ti)  p.ti  ~
  =/  de  (~(got by p.jon) 'description')
  =/  des  ?:  ?=($s -.de)  p.de  ~
  =/  au  (~(got by p.jon) 'author')
  =/  aut  ?:  ?=($s -.au)  p.au  ~
  =/  as  (~(got by p.jon) 'assignee')
  =/  ass  ?:  ?=($s -.as)  p.as  ~
  =.  pax 
    ::/(scot %tas hi)/=/app/taskk/(scot %tas bi)/(scot %tas phi)/(scot %da now.hid)/json
    :: for right now, only write to our urbit
    %/(scot %tas boa)/(scot %tas pha)/(scot %da now.hid)/md
  =/  txt
    %-  crip
    """
    ---
    author: {<aut>}
    assignee: {<ass>}
    title: {<tit>}
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
  :: it would be cool to have a confirmation response move, too
  ::
  [[ost.hid ca] ~]
::  used for changing board phase
::
++  change-phase
  |=  jon/json
  =|  {inp/path out/path ca/card}
  ^-  (list move)
  ?.  ?=($o -.jon)
    :: TODO return an error instead 
    [[ost.hid %diff %json ~] ~]
    ::
  =/  ho  (~(got by p.jon) 'host')
  =/  hos  ?:  ?=($s -.ho)  p.ho  ~
  =/  bo  (~(got by p.jon) 'board')
  =/  boa  ?:  ?=($s -.bo)  p.bo  ~
  =/  is  (~(got by p.jon) 'issue')
  =/  iss  ?:  ?=($s -.is)  p.is  ~
  =/  phn  (~(got by p.jon) 'from-phase')
  =/  phan  ?:  ?=($s -.phn)  p.phn  ~
  =/  pht  (~(got by p.jon) 'to-phase')
  =/  phat  ?:  ?=($s -.pht)  p.pht  ~
  =.  inp
    /(scot %tas hos)/home/(scot %da now.hid)/app/taskk/(scot %tas boa)/(scot %tas phan)/(scot %tas iss)/md
  =.  out
    /(scot %tas hos)/home/(scot %da now.hid)/app/taskk/(scot %tas boa)/(scot %tas phat)/(scot %tas iss)/md
  =.  ca
    :^
      %info
      /moving
      our.hid
      %+  furl
        (fray inp)
        (foal out [%md !>(.^(* %cx inp))])
  [[ost.hid ca] ~]
::  request a board
++  request-board
  |=  jon/json
  ^-  (list move)
  =|  car/card
  ?.  ?=($o -.jon)
    [[ost.hid %diff %json ~] ~]
    :::+
    ::  %diff
    ::  %json 
    ::%+
    ::  joba 
    ::  'error'
    ::  (jape "problem")
  :: map this whole thing
  =/  h  (~(got by p.jon) 'host')
  =/  b  (~(got by p.jon) 'board')
  =/  hi  ?:  ?=($s -.h)  p.h  ~
  =/  bi  ?:  ?=($s -.b)  p.b  ~
  =/  pax  (create-path [`@t`hi `@t`bi ~ ~])
  =.  car
    :+
      %diff
      %json
      (crawl-path pax)
  ~&  car
  %+  turn  (prey /sub-path hid)
    |=  {o/bone *}
    [o car]
::
::  request an issue
++  create-path
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
::
++  peer-sub-path
  |=  arg/*
  =|  jon/json
    ::
    :: tried to use case 0, but didn't work?
  =.  jon
    %+
      joba 
      'connected'
      (jape "success")
  [[[ost.hid %diff %json jon] ~] +>.$]
--
