NB. CLEAN-UP
clear''
require'viewmat'
coinsert'jgl2 jviewmat'

color=: 0 0 0
ix_r=: 0
ix_g=: 1
ix_b=: 2

clamp_color=: verb define
color=:(3#0)>. color <. 3#255
)

NB. color picker window - cpw
rgba_close=: verb define
wd'psel rgba;pclose;timer 0'
)

NB. SETUP
NB. 256xwidth
rgba_form=: noun define
pc rgba;
minwh 300 300;
bin v;
  cc showc isidraw;
    set showc wh 300 50;
  bin h;
    cc pickr isidraw;
      set pickr wh 50 256;
    cc pickg isidraw;
      set pickg wh 50 256;
    cc pickb isidraw;
      set pickb wh 50 256;
  bin z;
bin z;
pshow;
)

rgba_pickr_mblup=: verb define
color=:(1{".sysdata)ix_r}color
update_color_display''
)

rgba_pickg_mblup=: verb define
color=:(1{".sysdata)ix_g}color
update_color_display''
)

rgba_pickb_mblup=: verb define
color=:(1{".sysdata)ix_b}color
update_color_display''
)

update_color_display=: verb define
clamp_color''
wd'psel rgba'
glclear''[glsel'pickr'
(|: (i.256) ix_r} (|: 256 3 $ color)) viewmatcc (i.256 50);'pickr'
glpaint''
glclear''[glsel'pickg'
(|: (i.256) ix_g} (|: 256 3 $ color)) viewmatcc (i.256 50);'pickg'
glpaint''
glclear''[glsel'pickb'
(|: (i.256) ix_b} (|: 256 3 $ color)) viewmatcc (i.256 50);'pickb'
glpaint''
glsel'showc'
glclear''
glfill (color,255)
glpaint''
)

NB. MUSH!
rgba_mush=: verb define
if. IFQT
do. rgba_close^:(wdisparent'rgba')''
    wd rgba_form
    update_color_display''
else. echo 'hello, emacs'
end.
)

rgba_mush''