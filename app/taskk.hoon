::
::
::::  
  ::
  ::
/?    310
/-  taskk
[taskk .]
|%
  ++  card  
  $%  {$info wire @p toro}                              :: write to clay
      {$warp wire sock riff}                            :: watch a dir
      {$diff $taskk-create-issue tape tape tape}        :: update subscribers
      {$diff $json json} 
  ==
  ++  move  {bone card}                                  
--                                               
!:                                               
|_  {hid/bowl state/{subp/path wpat/path}}                         
::
++  poke-taskk-create-issue
  |=  iss/issue
  ^-  (quip move +>.$)
  =/  pax/path
  %+  welp 
    wpat.state
  :~  (crip pha.iss)
      (crip iss.iss)
      %md
  ==
  =/  ca/card
  :^    %info
      /writing
    our.hid
  (foal pax [%md !>((crip des.iss))])
  =/  car/card
  :+  %diff 
    %taskk-create-issue
  iss
  =/  out
  %+  turn  
    (prey subp.state hid)
  |=  {o/bone *}
  [o car]
  [(welp out ~[[ost.hid ca]]) +>.$]
::  delete issue
++  poke-taskk-delete-issue
  |=  iss/issue-ref
  ~&  %delete-issue-called
  ^-  (quip move +>.$)
  =/  inp/path
  %+  welp
    wpat.state
  :~  (crip pha.iss)
      (crip iss.iss)
      %md
  ==
  =/  car/card
  :^    %info
      /deleting
    our.hid
  (fray inp)
  [~[[ost.hid car]] +>.$]
::
::  change board phase
++  poke-taskk-change-phase
  |=  iss/change-ref
  ~&  %change-phase-called
  ^-  (quip move +>.$)
  =/  inp/path
  %+  welp
    wpat.state
  :~  (crip fpha.iss)
      (crip iss.iss)
      %md
  ==
  =/  out/path
  %+  welp
    wpat.state
  :~  (crip fpha.iss)
      (crip iss.iss)
      %md
  ==
  =/  ca/card
  :^    %info
      /moving
    our.hid
  %+  furl
    (fray inp)
  (foal out [%md !>(.^(* %cx inp))])
  [[[ost.hid ca] ~] +>.$]
::  request a board
++  poke-taskk-request-board
  |=  board/{ho/tape bo/tape}
  ^-  (quip move +>.$)
  =/  car/card
  :+  %diff
    %json
  %-  jobe
  :~  ['action-completed' (jape "request-board")]
      ['response-data' (crawl-path wpat.state)]
  ==
  :_  +>.$ 
  %+  turn  
    (prey subp.state hid)
  |=  {o/bone *}
  [o car]
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
::
::  subscribe to taskk front end
::
++  peer
  |=  pax/path
  ~&  [%subscribed-to pax]
  =/  lism/(list move)
  (watch-dir (welp /app/taskk pax))
  =/  jon/json
  %-  jobe 
  ~[['action-completed' (jape "connect")]]
  =/  wpat/path  
  %+  welp
    %+  tope
      [our.hid %home da+now.hid] 
    (flop (limo ['app' 'taskk' ~]))
  pax
  :_  %=  +>.$
        state  [pax wpat]
      ==
  %+  welp
    lism 
  [[ost.hid %diff %json jon] ~]
::
::  watch board dir for changes
++  watch-dir
  |=  a/path
  ::~&  [%watch-dir a]
  ^-  (list move)
  =/  soc/sock
  [our.hid our.hid]
  =/  rav/rave
  [%next %z da+now.hid a]
  =/  rif/riff
  [%home [~ rav]]
  =/  car/card
  :^    %warp
      a
    soc
  rif
  [[ost.hid car] ~]
::
::
:: accepts incoming writ
++  writ                                         
  |=  {way/wire rot/riot}
  ~&  [%rot rot]
    ::will update subscribers that node changed
    ::once that works reasonably
  =/  car/card
  :+  %diff
    %json
  %+  joba
    'updated'
  (jape "true")
  :-  %+  welp
        %+  turn 
          (prey subp.state hid)
        |=  {o/bone *}
        [o car]
  [(watch-dir way) +>.$]
++  prep  _`.
--
