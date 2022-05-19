chcp 1251
@echo on
for %%P in (*.pdf) do (
pdftocairo -png -r 300 -singlefile "%%P"
)
