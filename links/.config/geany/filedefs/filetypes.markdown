[build-menu]
EX_00_LB=_Execute
EX_00_CM=markdown "%f" > /tmp/markdowntest.html && sensible-browser "/tmp/markdowntest.html"
EX_00_WD=
FT_00_LB=_Preview
FT_00_CM=pymarkdown.py "%f" > /tmp/markdowntest.html && sensible-browser "/tmp/markdowntest.html"
FT_00_WD=
