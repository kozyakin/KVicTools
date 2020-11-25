# **MiKTeX KVicTools** 

Эта программа является надстройкой над пакетом **MiKTeX**, упрощающей и автоматизирующей установку поддержки русского языка.

По умолчанию, устанавливается поддержка русско-английских переносов в MiKTeX, после чего MiKTeX полностью готов к работе с русскими документами, включая поддержку функций библиографической базы данных средствами BiBTeX.

Необходимые для работы пакеты и шрифты будут устанавливаться «на лету» --- по мере возникновения в них потребности. Для этого **Вы должны иметь в доступности полный дистрибутив MiKTeX** --- либо на локальном диске или на CD/DVD, либо, имея быстрый и надежный доступ к Интернет.

В процессе установки пакета **MiKTeX KVicTools** Вам может быть предложено указать расположение файлов (repository) полного дистрибутива MiKTeX.

Если Вы имеете достаточно быстрое и надежное подключение к Интернету, то рекомендуется в качестве репозитария выбрать из предложенного Вам списка один из интернет-репозитариев MiKTeX.

Если подключение к Интернету невозможно, то Вам необходимо указать расположение файлов полного дистрибутива MiKTeX на локальном диске или CD/DVD.

После этого будет произведено обновление Вашей системы MiKTeX, и лишь затем будет запущен собственно инсталлятор пакета MiKTeX KVicTools.

**Пожалуйста, относитесь внимательно к окнам, в которых Вам предлагается выбрать репозитарий MiKTeX, так как в противном случае пакет MiKTeX KVicTools может быть установлен не полностью или с ошибками!**

**ВНИМАНИЕ! С 2018г. MiKTeX KVicTools более не устанавливает поддержку устаревших шрифтовых пакетов PSCyr и TXCyr.**

В случае, если в преамбуле Ваших файлов встретится строка
```
\usepackage[...]{pscyr}
```
ее рекомендуется заменить строкой
```
\usepackage{erewhon}
```
В случае, если в преамбуле Ваших файлов встретится строка
```
\usepackage[...]{txcyr}
```
ее следует заменить строками
```
\usepackage[proportional,space]{erewhon}
\usepackage[erewhon,vvarbb]{newtxmath}
```
При этом вместо
```
\usepackage[vvarbb]{newtxmath}
```
Может использоваться команда
```
\usepackage[vvarbb,slantedGreek]{newtxmath}
```
определяющая отрисовку по умолчанию греческих символов в режиме «италик».

В слайдах при использовании пакета beamer рекомендуется применять шрифт noto оптимизированный для web-презентаций
```
\usepackage[scaled=1.12]{nimbusmononarrow}% typewriter font
\usepackage[vvarbb,upint]{notomath}
```
Пакеты *pxcyr* и *txcyr* можно заменить также пакетами temporа, paratype и другими.

На вопросы, касающиеся **MiKTeX KVicTools**, Вам по возможности ответит [Victor Kozyakin](mailto:kozyakin@iitp.ru)

---

This program is an add-on over the **MiKTeX** package, which simplifies and automates the installation of Russian language support.

By default, support for Russian-English hyphenation is installed in MiKTeX, after which MiKTeX is completely ready to work with Russian documents, including support for bibliographic database functions by means of BiBTeX.

The packages and fonts required for work will be installed on the fly --- as the need arises. To do this **you must have the complete MiKTeX distribution available** --- either on a local disk or on a CD / DVD, or having fast and reliable Internet access.

During the installation of the MiKTeX KVicTools package, you may be asked to specify the location of the files (repository) of the complete MiKTeX distribution kit.

If you have a sufficiently fast and reliable connection to the Internet, then it is recommended to choose one of the MiKTeX Internet repositories from the list offered to you as a repository.

If the Internet connection is not possible, then you need to specify the location of the files of the complete MiKTeX distribution kit on a local disk or CD / DVD.

After that, your MiKTeX system will be updated, and only then the actual installer of the MiKTeX KVicTools package will be launched.

**Please, pay attention to the windows in which you are asked to select the MiKTeX repository, as otherwise the MiKTeX KVicTools package may not be fully installed or with errors!**

**ATTENTION! Since 2018. MiKTeX KVicTools no longer installs support for the legacy PSCyr and TXCyr font packages.**

In case the preamble of your files contains the line
```
\usepackage[...]{pscyr}
```
it is recommended to replace it with the string
```
\usepackage{erewhon}
```
In case the preamble of your files contains the line
```
\usepackage[...]{txcyr}
```
it should be replaced with strings
```
\usepackage[proportional,space]{erewhon}
\usepackage[erewhon,vvarbb]{newtxmath}
```
Moreover, instead of
```
\usepackage[vvarbb]{newtxmath}
```
The command can be used
```
\usepackage[vvarbb,slantedGreek]{newtxmath}
```
defining the default rendering of Greek characters in "Italian" mode.

It is recommended to use noto font optimized for web presentations in slides when using the beamer package
```
\usepackage[scaled=1.12]{nimbusmononarrow}% typewriter font
\usepackage[vvarbb,upint]{notomath}
```
The *pxcyr* and *txcyr* packages can also be replaced with the tempora, paratype, and others.

Questions regarding ** MiKTeX KVicTools **, if possible, will be answered by [Victor Kozyakin] (mailto: kozyakin@iitp.ru)