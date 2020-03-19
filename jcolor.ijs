clear''
require'viewmat'
coinsert'jgl2 jviewmat'

rgbw_form=: noun define
pc rgbw; pn "J-color";
bin v;
  cc showc isidraw; set showc wh 180 50;
  cc rgbc edit;
    set rgbc wh 180 25;
    set rgbc alignment center;
    set rgbc regexpvalidator \d{,3}(\s\d{,3}){2,2};
  bin h;
    cc pickr isidraw; set pickr wh 50 256;
    cc pickg isidraw; set pickg wh 50 256;
    cc pickb isidraw; set pickb wh 50 256;
  bin z;
bin z;
pshow;
)

rgbw_close=: monad : 'wd''psel rgbw;pclose;'''

rgbw_pickr_mblup=: monad : '0 adjust_color'
rgbw_pickg_mblup=: monad : '1 adjust_color'
rgbw_pickb_mblup=: monad : '2 adjust_color'
rgbw_showc_mblup=: monad : 'wd ''clipcopy #'',hex_color COLOR'
rgbw_rgbc_button=: monad : 'update[COLOR=: (3#0)>.(".wd''get rgbc text'')<.3#255'

COLOR=: 0 0 0

hex_color=: [:,[:_2&{."1[:'000'&,.[:":[:{&'0123456789ABCDEF'16&(#.^:_1)

adjust_color=: adverb define
COLOR=:(3#0)>.((1{".sysdata)(m})COLOR)<.3#255
update''
)

render_child=: verb define
glclear''[glsel child[wd'psel rgbw'['column child'=. y
((i.256)&(column})&.|:(256 3$COLOR))viewmatcc(i.256 50);child
glpaint''
)

update=: verb define
wd'psel rgbw'
render_child(2;'pickb')[render_child(1;'pickg')[render_child(0;'pickr')
glpaint''[glfill (COLOR,255)[glclear''[glsel'showc'
wd'set rgbc text "',(":COLOR),'"'
)

mush=: verb define
if. IFQT do. update[wd rgbw_form[rgbw_close^:(wdisparent'rgbw')''
else. echo 'no qt' end.
)

mush''