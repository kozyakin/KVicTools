chcp 1251
@echo on
for %%P in (%1) do (
pdftops "%%~nP.pdf" "%%~nP.ps"
rungs  -dPDFA=1 -dBATCH -dNOPAUSE -dPDFSETTINGS=/prepress -dNOOUTERSAVE -sColorConversionStrategy=UseDeviceIndependentColor -sProcessColorModel=DeviceRGB -sDEVICE=pdfwrite -sPDFACompatibilityPolicy=1 -sOutputFile="%%~nP.pdf" "%%~nP.ps"
del "%%~nP.ps"
)
