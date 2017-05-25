::
::
::::  
  ::
  :: TODO
  :: - delete issue
  ::
/?    310
|%
  ++  card  
    $%  {$info wire @p toro}                     :: write to clay
        {$warp wire sock riff}                   :: watch a dir
        {$diff mark *}                           :: update subscribers
    ==
  ++  move  {bone card}                          ::
--                                               ::
!:                                               ::
|_  {hid/bowl state/$~}                          ::
++  create-issue
  |=  jon/json
  ^-  (list move)
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
  =/  id/@tas
    (scot %da now.hid)
  =/  pax/path
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
  =/  ca/card
    :^
      %info
      /writing
      our.hid
      (foal pax [%md !>(txt)])
  =/  car/card
    :+
      %diff 
      %json 
      %-
        jobe 
        :~
          ['action-completed' jon] 
          ['issue-id' (jape (trip id))]
        ==
  =/  out
    %+  turn  (prey /sub-path hid)
      |=  {o/bone *}
      [o car]
  (welp out ~[[ost.hid ca]])
::
::  edit an existing issue
++  edit-issue
  |=  jon/json
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
  =/  pha  (~(got by p.jon) 'phase')
  =/  phas  ?:  ?=($s -.pha)  p.pha  ~
  =/  des  (~(got by p.jon) 'description')
  =/  desc  ?:  ?=($s -.des)  p.des  ~
  =/  pax/path
    /(scot %tas hos)/home/(scot %da now.hid)/app/taskk/(scot %tas boa)/(scot %tas phas)/(scot %tas iss)/md
  =/  ca/card
    :^
      %info
      /writing
      our.hid
      (foal pax [%md !>((scot %tas desc))])
  [[ost.hid ca] ~]
  ::
::  change board phase
++  change-phase
  |=  jon/json
  ~&  %change-phase-called
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
  =/  inp/path
    /(scot %tas hos)/home/(scot %da now.hid)/app/taskk/(scot %tas boa)/(scot %tas phan)/(scot %tas iss)/md
  =/  out/path
    /(scot %tas hos)/home/(scot %da now.hid)/app/taskk/(scot %tas boa)/(scot %tas phat)/(scot %tas iss)/md
  =/  ca/card
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
  ?.  ?=($o -.jon)
    [[ost.hid %diff %json ~] ~]
  :: map this whole thing
  :: list of keys
  :: map of keys and values
  =/  h  (~(got by p.jon) 'host')
  =/  b  (~(got by p.jon) 'board')
  =/  hi  ?:  ?=($s -.h)  p.h  ~
  =/  bi  ?:  ?=($s -.b)  p.b  ~
  =/  pax  (create-path [`@t`hi `@t`bi ~ ~])
  =/  car/card
    :+
      %diff
      %json
      (crawl-path pax)
  %+  turn  (prey /sub-path hid)
    |=  {o/bone *}
    [o car]
::
::  create a path
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
    ~&(%whoops !!)
      ::[ost.hid (joba 'error' (jape "problem"))]
  =/  a  (~(got by p.jin) 'action')
  =/  act  ?:  ?=($s -.a)  p.a  ~
  :: logic here to determine which action is being requested
  :: TODO use case here?
  =/  mo/(list move)
    ?:  =(act 'create-issue')
      (create-issue jin)
      ?:  =(act 'change-phase')  
        (change-phase jin)
        ?:  =(act 'edit-issue')  
          (edit-issue jin)
        (request-board jin)
  :_  +>.$
  mo
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
  :: leaves should be a different data structure
  [%s txt]
::  subscribe to taskk
::
++  peer-sub-path
  |=  arg/*
  =|  jon/json
  =.  jon
    %+
      joba 
      'connected'
      (jape "success")
  [[[ost.hid %diff %json jon] ~] +>.$]
--
