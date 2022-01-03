# **TeX Live KVicTools**

Эта программа является надстройкой над пакетом *TeX Live*, упрощающей и автоматизирующей установку поддержки русско-английских переносов.

По умолчанию, устанавливается поддержка русско-английских переносов в *TeX Live*, после чего *TeX Live* полностью готов к работе с русскими документами, включая поддержку функций библиографической базы данных средствами BiBTeX.

**ВНИМАНИЕ! С 2018г. TeX Live KVicTools более не устанавливает поддержку устаревших шрифтовых пакетов *PSCyr* и *TXCyr*.**

В случае, если в преамбуле Ваших файлов встретится строка

```latex
\usepackage[...]{pscyr}
```

ее рекомендуется заменить строкой

```latex
\usepackage{erewhon}
```

В случае, если в преамбуле Ваших файлов встретится строка

```latex
\usepackage[...]{txcyr}
```

ее следует заменить строками

```latex
\usepackage[proportional,space]{erewhon}
\usepackage[erewhon,vvarbb]{newtxmath}
```

При этом вместо

```latex
\usepackage[vvarbb]{newtxmath}
```

Может использоваться команда

```latex
\usepackage[vvarbb,slantedGreek]{newtxmath}
```

определяющая отрисовку по умолчанию греческих символов в режиме «италик».

В слайдах при использовании пакета beamer рекомендуется применять шрифт *noto*, оптимизированный для web-презентаций

```latex
\usepackage[scaled=1.12]{nimbusmononarrow}% typewriter font
\usepackage[vvarbb,upint]{notomath}
```

Пакеты *pxcyr* и *txcyr* можно заменить также пакетами temporа, paratype и другими.

На вопросы, касающиеся **TeX Live KVicTools**, Вам по возможности ответит [Victor Kozyakin](mailto:kozyakin@iitp.ru)

---

This program is an add-on over the *TeX Live* package that simplifies and automates the installation of support for Russian-English hyphenation.

By default, support for Russian-English hyphenation is installed in *TeX Live*, after which *TeX Live* is completely ready to work with Russian documents, including support for bibliographic database functions using BiBTeX.

**ATTENTION! Since 2018 TeX Live KVicTools no longer installs support for the legacy *PSCyr* and *TXCyr* font packages.**

In case the preamble of your files contains the line

```latex
\usepackage[...]{pscyr}
```

it is recommended to replace it with the string

```latex
\usepackage{erewhon}
```

In case the preamble of your files contains the line

```latex
\usepackage[...]{txcyr}
```

it should be replaced with strings

```latex
\usepackage[proportional,space]{erewhon}
\usepackage[erewhon,vvarbb]{newtxmath}
```

Moreover, instead of

```latex
\usepackage[vvarbb]{newtxmath}
```

The command can be used

```latex
\usepackage[vvarbb,slantedGreek]{newtxmath}
```

defining the default rendering of Greek characters in "Italian" mode.

It is recommended to use *noto*  font optimized for web presentations in slides when using beamer package

```latex
\usepackage[scaled=1.12]{nimbusmononarrow}% typewriter font
\usepackage[vvarbb,upint]{notomath}
```

The *pxcyr* and *txcyr* packages can also be replaced with the tempora, paratype, and others.

Questions regarding **TeX Live KVicTools** will be answered by [Victor Kozyakin](mailto:kozyakin@iitp.ru)
