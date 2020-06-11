coclass 'jcolor'
require 'viewmat'
coinsert'jgl2 jviewmat'

COLOR=: 0 0 0
HISTORY=: ,:0 0 0
HISTSIZE=: 10

rgbw_form=: 0 : 0
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

rgbw_close=: 3 : 0
wd'psel rgbw;pclose;'
wd 'clipcopy ',": COLOR
)

rgbw_pickr_mblup=: 3 : '0 adjust_color'
rgbw_pickg_mblup=: 3 : '1 adjust_color'
rgbw_pickb_mblup=: 3 : '2 adjust_color'
rgbw_showc_mblup=: 3 : 'wd ''clipcopy '',": COLOR'

record_hist=: 3 : 0
HISTORY=: ~. (<./HISTSIZE,>:#HISTORY) {. COLOR , HISTORY
wd 'set histt items',,/(' ','"'&,@,&'"'@":)"1 HISTORY
)

adjust_color=: 1 : 0
COLOR=:(3#0)>.((1{".sysdata)(m})COLOR)<.3#255
update''
)

update=: 3 : 0
record_hist''
wd'psel rgbw'
render_child(2;'pickb')[render_child(1;'pickg')[render_child(0;'pickr')
glpaint''[glfill (COLOR,255)[glclear''[glsel'showc'
wd'set rgbc text "',(":COLOR),'"'
)

render_child=: 3 : 0
glclear''[glsel child[wd'psel rgbw'['column child'=. y
((i.256)&(column})&.|:(256 3$COLOR))viewmatcc(i.256 50);child
glpaint''
)

rgbw_rgbc_button=: 3 : 'update[COLOR=: (3#0)>.(".wd''get rgbc text'')<.3#255'

rgbw_copyt_select=: 3 : 0
select. copyt
case. 'hex' do. rgbw_showc_mblup=: 3 : 'wd ''clipcopy #'',": hex COLOR'
case. 'rgb' do. rgbw_showc_mblup=: 3 : 'wd ''clipcopy '',": COLOR'
end. 'ok'
)

rgbw_histt_select=: 3 : 0
COLOR=: ". histt
update''
)

hex=: [:,[:_2&{."1[:'000'&,.[:":[:{&'0123456789ABCDEF'16&(#.^:_1)

courir=: 3 : 0
if. IFQT do. update[wd rgbw_form[rgbw_close^:(wdisparent'rgbw')''
else. echo 'needs qt' end.
)
