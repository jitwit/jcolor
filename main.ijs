clear''
require'viewmat'
coinsert'jgl2 jviewmat'

color=: 0 0 0
colors_table=: cut &.> newline cut freads<'~/code/jcolor/names.txt'[newline=:10{a.
color_rgbs_dups=: ".>>3&{. &.> colors_table
color_unique_sieve=: ~: color_rgbs_dups
color_names=: ' '&joinstring &.> 3&}. &.> color_unique_sieve # colors_table
color_rgbs=: color_unique_sieve # color_rgbs_dups

dcolor=: [: +/ [: | -

display_ix_color=: verb define
< newline joinstring (>y { color_names);(":y{color_rgbs)
)

closest_colors=: verb define
ix=.(i. <./) y (([: +/ [: *: -~)"1 1) color_rgbs
(2#newline) joinstring (display_ix_color"0) 4 {. /: y dcolor"1 1 color_rgbs
)

rgbw_form=: noun define
pc rgbw;
bin v;
  cc showc isidraw; set showc wh 400 50;
  bin h;
    cc pickr isidraw; set pickr wh 50 256;
    cc pickg isidraw; set pickg wh 50 256;
    cc pickb isidraw; set pickb wh 50 256;
    bin v;
      cc rgbc edit;
        set rgbc wh 200 25;
        NB. allow 0 digits because deleting a number can get blocked
        set rgbc regexpvalidator \d{,3}(\s\d{,3}){2,2};
      cc rgbn editm readonly; set rgbn wh 200 220;
    bin z;
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
wd'set rgbn text "',(closest_colors color),'"'
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