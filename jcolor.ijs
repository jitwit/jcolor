coclass 'jcolor'
require 'viewmat'
coinsert'jgl2 jviewmat'

COLOR=: 0 0 0
HISTORY=: ,:0 0 0
HISTSIZE=: 10

rgbw_form=: noun define
pc rgbw; pn "J-color";
bin h;
  cc pickr isidraw; set pickr wh 50 256;
  cc pickg isidraw; set pickg wh 50 256;
  cc pickb isidraw; set pickb wh 50 256;
  bin v;
    cc showc isidraw; set showc wh 180 180;
    cc rgbc edit; set rgbc wh 180 25; set rgbc alignment center;
      set rgbc regexpvalidator \d{,3}(\s\d{,3}){2,2};
    cc copyt combolist; set copyt items rgb hex;
    cc histt combolist; set histt items "0 0 0";
  bin z;
bin z;
pshow;
)

rgbw_close=: monad : 'wd''psel rgbw;pclose;'''

rgbw_pickr_mblup=: monad : '0 adjust_color'
rgbw_pickg_mblup=: monad : '1 adjust_color'
rgbw_pickb_mblup=: monad : '2 adjust_color'
rgbw_showc_mblup=: monad : 'wd ''clipcopy '',": COLOR'

record_hist=: 3 : 0
HISTORY=: ~. (<./HISTSIZE,>:#HISTORY) {. COLOR , HISTORY
wd 'set histt items',,/(' ','"'&,@,&'"'@":)"1 HISTORY
)

adjust_color=: 1 : 0
COLOR=:(3#0)>.((1{".sysdata)(m})COLOR)<.3#255
record_hist''
update''
)

update=: verb define
wd'psel rgbw'
render_child(2;'pickb')[render_child(1;'pickg')[render_child(0;'pickr')
glpaint''[glfill (COLOR,255)[glclear''[glsel'showc'
wd'set rgbc text "',(":COLOR),'"'
)

render_child=: verb define
glclear''[glsel child[wd'psel rgbw'['column child'=. y
((i.256)&(column})&.|:(256 3$COLOR))viewmatcc(i.256 50);child
glpaint''
)

rgbw_rgbc_button=: monad : 'update[COLOR=: (3#0)>.(".wd''get rgbc text'')<.3#255'

rgbw_copyt_select=: monad define
select. copyt
case. 'hex' do. rgbw_showc_mblup=: monad : 'wd ''clipcopy #'',": hex COLOR'
case. 'rgb' do. rgbw_showc_mblup=: monad : 'wd ''clipcopy '',": COLOR'
end. 'ok'
)

rgbw_histt_select=: monad define
COLOR=: ". histt
record_hist''
update''
)

hex=: [:,[:_2&{."1[:'000'&,.[:":[:{&'0123456789ABCDEF'16&(#.^:_1)

courir=: verb define
if. IFQT do. update[wd rgbw_form[rgbw_close^:(wdisparent'rgbw')''
else. echo 'needs qt' end.
)

courir''
