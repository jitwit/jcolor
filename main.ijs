coclass 'jcolor'
clear''
require'viewmat'
coinsert'jgl2 jviewmat'

rgbw_form=: noun define
pc rgbw;
bin vs;
  cc showc isidraw; set showc wh 300 50;
  bin h;
    cc pickr isidraw; set pickr wh 50 256;
    cc pickg isidraw; set pickg wh 50 256;
    cc pickb isidraw; set pickb wh 50 256;
    cc rgbc edit;
      set rgbc wh 85 25;
      set rgbc limit 11;
      NB. allow 0 digits because deleting a number can get blocked
      set rgbc regexpvalidator \d{,3}(\s\d{,3}){2,2}; 
  bin z;
bin z;
pshow;
)


rgbw_close=: verb define
wd'psel rgbw;pclose;'
)

rgbw_pickr_mblup=: monad : '0 adjust_color'
rgbw_pickg_mblup=: monad : '1 adjust_color'
rgbw_pickb_mblup=: monad : '2 adjust_color'

rgbw_rgbc_button=: monad define
color=: (3#0)>.(".wd'get rgbc text')<.3#255
update''
)

color=: 0 0 0

hex_color=: [:,[:_2&{."1[:'000'&,.[:":[:{&'0123456789ABCDEF' 16&(#.^:_1)

adjust_color=: adverb define
color=:(3#0)>.((1{".sysdata)(m})color)<.3#255
update''
)

render_child=: verb define
glclear''[glsel child[wd'psel rgbw'['column child'=. y
((i.256)&(column})&.|:(256 3$color))viewmatcc(i.256 50);child
glpaint''
)

update=: verb define
wd'psel rgbw'
render_child(2;'pickb')[render_child(1;'pickg')[render_child(0;'pickr')
glpaint''[glfill (color,255)[glclear''[glsel'showc'
wd'set rgbc text "',(":color),'"'
clr=.'#',hex_color color
wd'pn "',clr,'"'[wd'clipcopy ',clr
)

mush=: verb define
if. IFQT
do. rgbw_close^:(wdisparent'rgbw')''
    wd rgbw_form
    update''
else. echo 'no qt'
end.
)

mush''