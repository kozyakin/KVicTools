chcp 1251
@echo on
for %%P in (%1) do (
rungs  -dBATCH -dNOPAUSE -sColorConversionStrategy=RGB -sProcessColorModel=DeviceRGB -dOverrideICC=true -sDEVICE=pdfwrite  -dAutoRotatePages=/None -sOutputFile="%%~nP-pdfa.pdf" "%%P"
del "%%P"
ren "%%~nP-pdfa.pdf" "%%P"
)
