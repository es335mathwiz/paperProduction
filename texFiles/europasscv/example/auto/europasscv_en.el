(TeX-add-style-hook
 "europasscv_en"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("europasscv" "english" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "english")))
   (TeX-run-style-hooks
    "latex2e"
    "europasscv"
    "europasscv10"
    "babel")))

