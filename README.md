# KVicTools
Здесь собраны некоторые программы и скрипты, предназначенные для настройки поддержки русского языка в системах *MikTeX* и *TeX Live*, а также редакторе *WinEdt*.

### MikTeX и TeX Live

Добавлены единые паттерны русско-английских переносов, стилевой файл для проверки "ссылок вперед" в теховских файлах, модифицированные стилевые файлы для русской библиографии в стиле ГОСТ и др. 

Исходные файлы для построения инсталляторов: [MiKTeX](https://github.com/kozyakin/KVicTools/tree/main/MiKTeX) и [TeX Live](https://github.com/kozyakin/KVicTools/tree/main/TeXLive)

### WinEdt

Добавлен перевод всех элементов интерфейса *WinEdt 10.3 и 11.0* на русский язык, а также существенно дополнен набор сервисных макросов для выполнения повседневных нужд - поиск и чистка мусора, перекодировка документов, поиск неиспользуемых или многократно используемых ссылок и меток и др.

Исходные файлы для построения инсталляторов: [WinEdt 10.3](https://github.com/kozyakin/KVicTools/tree/main/WinEdt%2010) и [WinEdt 11.0](https://github.com/kozyakin/KVicTools/tree/main/WinEdt%2011)

### Другое

##### Файлы локализации MikTeX,TexLive, WinEdt 10.3, WinEdt 11.0:

- setup-MiKTeX-KVicTools.exe
- setup-TeXLive-KVicTools.exe
- setup-WinEdt-10.3-KVicTools.exe
- setup-WinEdt-11.0-KVicTools.exe

##### Набор сервисных cmd-файлов для массовой перекодировки pdf-документов в eps:

- pdf\_page\_group\_removing.cmd
- pdf\_page\_group\_removing\_single\_file.cmd
- pdf\_to\_eps\_batch.cmd
- pdf\_to\_eps\_single\_file.cmd
- pdf\_to\_pdfa\_batch.cmd
- pdf\_to\_pdfa\_single\_file.cmd
- pdf\_to\_png\_batch.cmd
- pdf\_to\_png\_single\_file.cmd

##### Набор сервисных cmd-файлов для  обновления TeXLive, менеджера пакетов *tlmgr* и др.

- tlmgr\_update\_list.cmd
- tlmgr\_update\_self\_all.cmd
- tlmgr\_update\_self\_only.cmd
- tlmgr-restore\_path.cmd



---



Here are collected some programs and scripts designed to configure support for the Russian language in *MikTeX*, *TeX Live* systems and the *WinEdt* editor.

### MikTeX and TeX Live

Added common patterns of Russian-English hyphenation, a style file for checking "forward links" in tex-files, modified style files for Russian bibliography in the GOST style, etc.

Sources to build installers: [MiKTeX](https://github.com/kozyakin/KVicTools/tree/main/MiKTeX) and [TeX Live](https://github.com/kozyakin/KVicTools/tree/main/TeXLive)

### WinEdt

The translation of all elements of the *WinEdt 10.3 and 11.0* interface into Russian has been added, as well as the set of service macros for fulfilling everyday needs has been significantly expanded - searching and cleaning garbage, recoding documents, finding unused or reused links, labels and tags, etc.

Sources to build installers: [WinEdt 10.3](https://github.com/kozyakin/KVicTools/tree/main/WinEdt%2010) and [WinEdt 11.0](https://github.com/kozyakin/KVicTools/tree/main/WinEdt%2011)

### Other

##### MikTeX, TexLive, WinEdt 10.3, WinEdt 11.0 localization files:

- setup-MiKTeX-KVicTools.exe
- setup-TeXLive-KVicTools.exe
- setup-WinEdt-10.3-KVicTools.exe
- setup-WinEdt-11.0-KVicTools.exe

##### A set of service cmd files for mass conversion of pdf documents to eps:

- pdf\_page\_group\_removing.cmd
- pdf\_page\_group\_removing\_single\_file.cmd
- pdf\_to\_eps\_batch.cmd
- pdf\_to\_eps\_single\_file.cmd
- pdf\_to\_pdfa\_batch.cmd
- pdf\_to\_pdfa\_single\_file.cmd
- pdf\_to\_png\_batch.cmd
- pdf\_to\_png\_single\_file.cmd

##### A set of service cmd files for updating TeXLive, *tlmgr* package manager, etc.

- tlmgr\_update\_list.cmd
- tlmgr\_update\_self\_all.cmd
- tlmgr\_update\_self\_only.cmd
- tlmgr-restore\_path.cmd
