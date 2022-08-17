**TeX Live KVicTools** является надстройкой над пакетом **TeX Live**, упрощающей и автоматизирующей установку поддержки русско-английских переносов.

По умолчанию, устанавливается поддержка русско-английских переносов в TeX Live, после чего TeX Live полностью готов к работе с русскими документами, включая поддержку функций библиографической базы данных средствами BiBTeX.

**ВНИМАНИЕ!** С 2018г. **TeX Live KVicTools** более не устанавливает поддержку устаревших шрифтовых пакетов `PSCyr` и `TXCyr`.

В случае, если в преамбуле Ваших файлов встретится строка

`\usepackage\[…\]{pscyr}`

ее рекомендуется заменить строкой

`\usepackage{erewhon}`

В случае, если в преамбуле Ваших файлов встретится строка

`\usepackage[…]{txcyr}`

ее следует заменить строками

`\usepackage[proportional,space]{erewhon}`<br>
`\usepackage[erewhon,vvarbb]{newtxmath}`

При этом вместо

`\usepackage[vvarbb]{newtxmath}`

может использоваться команда

`\usepackage[vvarbb,slantedGreek]{newtxmath}`

определяющая отрисовку по умолчанию греческих символов в режиме «италик».

В слайдах при использовании пакета beamer рекомендуется применять шрифт `noto`, оптимизированный для web-презентаций

`\usepackage[scaled=1.12]{nimbusmononarrow}% typewriter font`<br>
`\usepackage[vvarbb,upint]{notomath}`

Пакеты `pxcyr` и `txcyr` можно заменить также пакетами `temporа`, `paratype` и другими.

На вопросы, касающиеся **TeX Live KVicTools**, Вам по возможности ответит [Victor Kozyakin](mailto:kozyakin@iitp.ru)
