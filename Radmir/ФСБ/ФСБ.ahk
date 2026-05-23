; Информация про пользователя

name := "Адриан"
surname := "Аудиторе"
department := "ОБК"
rank := "Подполковник"
alias := "Бункер"



; Пользовательская настройка скрипта (True - Включено, False - Выключено)

keyModifier := "" ; Специальная клавиша для замены Numpad'a (Нажимаете эту клавишу + цифру на основной клавиатуре)
full_rp := false ; Отыгровки даже там, где не нужны (Иначе будут только обязательные отыгровки)
hotkeys := true ; Включение и отключение горячих клавиш (Нужны ли они вообще?)
commands := true ; Включение и отключение команд (Нужны ли они вообще?)
check_updates := true ; Проверять обновления при запуске скрипта (Рекомендуется включить, чтобы не пропустить важные обновления)



; Системные настройки скрипта

#UseHook
#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SetKeyDelay, -1, 10
SetBatchLines, -1
#MaxHotkeysPerInterval 500
#HotkeyInterval 500
#Hotstring EndChars `n
#Hotstring ? *0
#Hotstring NoMouse

#InstallKeybdHook
#InstallMouseHook
#Persistent

SheetID := "1rzhOmfLUJWiapzrLHOvieSlCn1cnKCGiI2Tbi0ulOL0"
UK_TAB := "508244995"
KOAP_TAB := "602546729"
PROC_TAB := "1080025566"
MO_TAB := "0"
MVD_TAB := "609243074"
SOBR_TAB := "819076183"
FSIN_TAB := "1338576818"
FAKEL_TAB := "1947143567"
FSB_TAB := "362432518"

VERSION := "v1.0.1"




; Остальные переменные для работы скрипта

infoState := false
scriptMode := 0 ; 0 - Обычный, 1 - Строй, 2 - Допрос/вербовка, 3 - Маскировка
playerId := "null"
fakeName := ""
fakeRank := ""

VERSION_LINE_PATTERN := "VERSION :=" 
RAW_URL  := "https://raw.githubusercontent.com/Ilyuxadwa/AHKScripts/refs/heads/main/Radmir/%D0%A4%D0%A1%D0%91/%D0%A4%D0%A1%D0%91.ahk"
TMP_FILE := A_Temp . "\AHKUpdate.ahk"
USER_CONFIG_VARS := ["name", "surname", "department", "rank", "alias"]

if (check_updates)
    CheckForUpdates()

KeyInfo("Проиходит запуск скрипта...", "")

Global UK_DATA = Parser(SheetID, UK_TAB)
Global KOAP_DATA = Parser(SheetID, KOAP_TAB)
Global PROC_DATA = Parser(SheetID, PROC_TAB)
Global MO_DATA = Parser(SheetID, MO_TAB)
Global MVD_DATA = Parser(SheetID, MVD_TAB)
Global SOBR_DATA = Parser(SheetID, SOBR_TAB)
Global FSIN_DATA = Parser(SheetID, FSIN_TAB)
Global FAKEL_DATA = Parser(SheetID, FAKEL_TAB)
Global FSB_DATA = Parser(SheetID, FSB_TAB)

Global UKLines := []
for id, entry in UK_DATA {
    if (entry.reason != "")
    {
        UKLines.Push(entry.id . " | " . entry.reason)
    } else {
        UKLines.Push(entry.id)
    }
}

Global KOAPLines := []
for id, entry in KOAP_DATA {
    if (entry.reason != "")
    {
        KOAPLines.Push(entry.id . " | " . entry.reason)
    } else {
        KOAPLines.Push(entry.id)
    }
}

Global PROCLines := []
for id, entry in PROC_DATA {
    if (entry.reason != "")
    {
        PROCLines.Push(entry.id . " | " . entry.reason)
    } else {
        PROCLines.Push(entry.id)
    }
}

Global MOLines := []
for id, entry in MO_DATA {
    if (entry.reason != "")
    {
        MOLines.Push(entry.id . " | " . entry.reason)
    } else {
        MOLines.Push(entry.id)
    }
}

Global MVDLines := []
for id, entry in MVD_DATA {
    if (entry.reason != "")
    {
        MVDLines.Push(entry.id . " | " . entry.reason)
    } else {
        MVDLines.Push(entry.id)
    }
}

Global SOBRLines := []
for id, entry in SOBR_DATA {
    if (entry.reason != "")
    {
        SOBRLines.Push(entry.id . " | " . entry.reason)
    } else {
        SOBRLines.Push(entry.id)
    }
}

Global FSINLines := []
for id, entry in FSIN_DATA {
    if (entry.reason != "")
    {
        FSINLines.Push(entry.id . " | " . entry.reason)
    } else {
        FSINLines.Push(entry.id)
    }
}

Global FAKELLines := []
for id, entry in FAKEL_DATA {
    if (entry.reason != "")
    {
        FAKELLines.Push(entry.id . " | " . entry.reason)
    } else {
        FAKELLines.Push(entry.id)
    }
}

Global FSBLines := []
for id, entry in FSB_DATA {
    if (entry.reason != "")
    {
        FSBLines.Push(entry.id . " | " . entry.reason)
    } else {
        FSBLines.Push(entry.id)
    }
}

KeyInfo("AHK для ФСБ by Foster"
        , ""
        , "Скрипт включает в себя не только стандартные функции ФСБ, но и АХК других организаций."
        , "Поддерживается как ручной ввод id игрока, так и автоматический, который вы введете заранее. (0)"
        , "Можно нажимать как на клавиши, так и вводить текстовые команды в чат."
        , "Для доп. информации: https://github.com/Ilyuxadwa/AHKScripts/blob/main/Radmir/ФСБ/Info.md"
        , ""
        , "P.S. Бладарность за помощь: German_Mackelly, Andrew_Harada")

SavedInfo(playerId, fakeName)
Sleep 3000
Goto DestroyInfo
Return



; Назначение клавиш

#If (scriptMode = 0) && hotkeys && (keyModifier = "")
Numpad0::Goto ВводId
LAlt & Numpad0::Goto ОчиститьId
Ctrl & Numpad0::Goto ВводНика
RAlt & Numpad0::Goto ОчиститьНик

Numpad1::Goto Приветствие
LAlt & Numpad1::Goto УдостоверениеФСБ
Ctrl & Numpad1::Goto Нашивка

Numpad2::Goto ПросьбаОстановится
LAlt & Numpad2::Goto РаботаФСБ
NumpadDown::Goto РаботаМегафонФСБ
Ctrl & Numpad2::Goto ПросьбаДокументов
RAlt & Numpad2::Goto ВзятьДокументы

Numpad3::Goto ОтследитьМестоположение
LAlt & Numpad3::Goto НачатьПогоню
Ctrl & Numpad3::Goto Арест
RAlt & Numpad3::Goto ОтменаАреста

Numpad4::Goto Обыск
LAlt & Numpad4::Goto НайденаЗапрещенка
Ctrl & Numpad4::Goto ОбыскДоков
RAlt & Numpad4::Goto ОбыскБагажника

Numpad5::Goto СнятьАксессуары
LALt & Numpad5::Goto Фоторобот
Ctrl & Numpad5::Goto ЧеловекОтпечатки
RAlt & Numpad5::Goto ЧеловекНЗ

Numpad6::Goto Розыск
LAlt & Numpad6::Goto Штраф
Ctrl & Numpad6::Goto ЗабратьЛицензию
RAlt & Numpad6::Goto СнятьРозыск

Numpad7::Goto ВыкинутьИзАвто
LAlt & Numpad7::Goto ПосадитьВАвто
Ctrl & Numpad7::Goto ВыломатьДверь

Numpad8::Goto ЗачитатьПрава
LAlt & Numpad8::Goto ВызватьАдвоката
Ctrl & Numpad8::Goto НеАдвокат

Numpad9::Goto ПоставитьБарикаду
LAlt & Numpad9::Goto УбратьБарикаду
Ctrl & Numpad9::Goto Выговор
RAlt & Numpad9::Goto Уволить
#If
#If (scriptMode = 1) && hotkeys && (keyModifier = "")
Numpad0::Goto Строй

LAlt & Numpad0::Goto СтройИнфо

Numpad1::Goto Лекция
Numpad2::Goto Тренировка
#If
#If (scriptMode = 2) && hotkeys && (keyModifier = "")
Numpad0::Goto ДопросМиранда
Ctrl & Numpad0::Goto Принятие

Numpad1::Goto ДопросНачало
Alt & Numpad1::Goto ВербовкаКонец
Ctrl & Numpad1::Goto Повышение

Numpad2::Goto ДопросПродолжение
Ctrl & Numpad2::Goto ЧёрныйСписок

Numpad3::Goto ДопросКонец

Numpad4::Goto ВербовкаПроверка1
LAlt & Numpad4::Goto ПроверитьДокументЧеловека
Numpad5::Goto ВербовкаПроверка2
Numpad6::Goto ВербовкаПроверка3
Numpad7::Goto ВербовкаПроверка4
Numpad8::Goto ВербовкаПроверка5

LAlt & Numpad8::Goto ВербовкаОК
Ctrl & Numpad8::Goto ВербовкаОтказ

Numpad9::Goto Конфиденциальность
LAlt & Numpad9::Goto КонфиденциальностьМаксимум
#If
#If (scriptMode = 3) && hotkeys && (keyModifier = "")
Numpad0::Goto ПриветствиеМО
LAlt & Numpad0::Goto ЛекцияМО

Numpad1::Goto ПриветствиеМВД
LAlt & Numpad1::Goto ЛекцияМВД

Numpad2::Goto ПриветствиеФСИН
LAlt & Numpad2::Goto ЛекцияФСИН

Numpad3::Goto НачатьПрослушку
#If
#If (scriptMode = 0) && hotkeys && (keyModifier != "") && GetKeyState(keyModifier, "P")
1::Goto ВводId
<!1::Goto ОчиститьId
^1::Goto ВводНика
>!1::Goto ОчиститьНик

2::Goto Приветствие
<!2::Goto УдостоверениеФСБ
^2::Goto Нашивка

3::Goto ПросьбаОстановится
<!3::Goto РаботаФСБ
Shift & 3::Goto РаботаМегафонФСБ
^3::Goto ПросьбаДокументов
>!3::Goto ВзятьДокументы

4::Goto ОтследитьМестоположение
<!4::Goto НачатьПогоню
^4::Goto Арест
>!4::Goto ОтменаАреста

5::Goto Обыск
<!5::Goto НайденаЗапрещенка
^5::Goto ОбыскДоков
>!5::Goto ОбыскБагажника

6::Goto СнятьАксессуары
LALt & 6::Goto Фоторобот
^6::Goto ЧеловекОтпечатки
>!6::Goto ЧеловекНЗ

7::Goto Розыск
<!7::Goto Штраф
^7::Goto ЗабратьЛицензию
>!7::Goto СнятьРозыск

8::Goto ВыкинутьИзАвто
<!8::Goto ПосадитьВАвто
^8::Goto ВыломатьДверь

9::Goto ЗачитатьПрава
<!9::Goto ВызватьАдвоката
^9::Goto НеАдвокат

0::Goto ПоставитьБарикаду
<!0::Goto УбратьБарикаду
^0::Goto Выговор
>!0::Goto Уволить
#If
#If (scriptMode = 1) && hotkeys && (keyModifier != "") && GetKeyState(keyModifier, "P")
1::Goto Строй
<!1::Goto СтройИнфо

2::Goto Лекция
3::Goto Тренировка
#If
#If (scriptMode = 2) && hotkeys && (keyModifier != "") && GetKeyState(keyModifier, "P")
1::Goto ДопросМиранда
^1::Goto Принятие

2::Goto ДопросНачало
<!2::Goto ВербовкаКонец
^2::Goto Повышение

3::Goto ДопросПродолжение
^3::Goto ЧёрныйСписок

4::Goto ДопросКонец

5::Goto ВербовкаПроверка1
<!5::Goto ПроверитьДокументЧеловека
6::Goto ВербовкаПроверка2
7::Goto ВербовкаПроверка3
8::Goto ВербовкаПроверка4
9::Goto ВербовкаПроверка5

<!9::Goto ВербовкаОК
^9::Goto ВербовкаОтказ

0::Goto Конфиденциальность
<!0::Goto КонфиденциальностьМаксимум
#If
#If (scriptMode = 3) && hotkeys && (keyModifier != "") && GetKeyState(keyModifier, "P")
1::Goto ПриветствиеМО
<!1::Goto ЛекцияМО

2::Goto ПриветствиеМВД
<!2::Goto ЛекцияМВД

3::Goto ПриветствиеФСИН
<!3::Goto ЛекцияФСИН

4::Goto НачатьПрослушку
#If
Ctrl & LAlt::Goto ПереключитьАхк



; Назначение команд

#If commands
::/iid::
::.шшв::
::.ид::
CommandHelper()
Goto ВводId

::/clearid::
::.сдуфкшв::
::.сид::
CommandHelper()
Goto ОчиститьId

::/nick::
::.тшсл::
::.ник::
CommandHelper()
Goto ВводНика

::/clearnick::
::.сдуфктшсл::
::.сник::
CommandHelper()
Goto ОчиститьНик

::/hello::
::.руддщ::
::.прив::
CommandHelper()
Goto Приветствие

::/badge::
::.ифвпу::
::.бейдж::
CommandHelper()
Goto Нашивка

::/doc::
::.вщс::
::.док::
CommandHelper()
Goto УдостоверениеФСБ

::/stop::
::.ыещз::
::.стоп::
CommandHelper()
Goto ПросьбаОстановится

::/fsb::
::.аыи::
::.фсб::
CommandHelper()
Goto РаботаФСБ

::/mfsb::
::.ьаыи::
::.мфсб::
CommandHelper()
Goto РаботаМегафонФСБ

::/askdoc::
::.фылвщс::
::.дайдок::
CommandHelper()
Goto ПросьбаДокументов

::/pg::
::.зп::
::.пг::
CommandHelper()
Goto НачатьПогоню

::/cuff::
::.сгаа::
::.каф::
CommandHelper()
Goto Арест

::/uncuff::
::.гтсгаа::
::.анкаф::
CommandHelper()
Goto ОтменаАреста

::/search::
::.ыуфкср::
::.обыск::
CommandHelper()
Goto Обыск

::/zapretka::
::.яфзкуелф::
::.запрещенка::
CommandHelper()
Goto НайденаЗапрещенка

::/takedocs::
::.ефлувщсы::
::.взять_доки::
CommandHelper()
Goto ВзятьДокументы

::/checkdocs::
::.сруслвщсы::
::.чекдокс::
CommandHelper()
Goto ОбыскДоков

::/check_trunk::
::.срусл_екгтл::
::.чектранк::
CommandHelper()
Goto ОбыскБагажника

::/acc_off::
::.фсс_щаа::
::.аксы::
CommandHelper()
Goto СнятьАксессуары

::/photorobot::
::.зрщещкщище::
::.фоторобот::
CommandHelper()
Goto Фоторобот

::/by_finger::
::.ин_аштпук::
::.пальчики::
CommandHelper()
Goto ЧеловекОтпечатки

::/by_plate::
::.ин_здфеу::
::.номера::
CommandHelper()
Goto ЧеловекНЗ

::/su::
::.ыг::
::.розыск::
CommandHelper()
Goto Розыск

::/ticket::
::.ешслуе::
::.штраф::
CommandHelper()
Goto Штраф

::/takelic::
::.ефлудшс::
::.лицензия::
CommandHelper()
Goto ЗабратьЛицензию

::/clear::
::.сдуфк::
::.клиар::
CommandHelper()
Goto СнятьРозыск

::/ejectout::
::.уощсещге::
::.еджект::
CommandHelper()
Goto ВыкинутьИзАвто

::/putpl::
::.згезд::
::.путпл::
CommandHelper()
Goto ПосадитьВАвто

::/break_door::
::.икуфл_вщщк::
::.дверь::
CommandHelper()
Goto ВыломатьДверь

::/miranda::
::.ьшкфтвф::
::.миранда::
CommandHelper()
Goto ЗачитатьПрава

::/advokat::
::.фвмщлфе::
::.адвокат::
CommandHelper()
Goto ВызватьАдвоката

::/neadvokat::
::.туфвмщлфе::
::.неадвокат::
CommandHelper()
Goto НеАдвокат

::/setmark::
::.ыуеьфкл::
::.метка::
CommandHelper()
Goto ОтследитьМестоположение

::/fwarn::
::.ацфкт::
::.выг::
CommandHelper()
Goto Выговор

::/uninvite::
::.гтштмшеу::
::.увал::
CommandHelper()
Goto Уволить

::/listen::
::.дшыеут::
::.прослушка::
CommandHelper()
Goto НачатьПрослушку

::/break::
::.икуфл::
::.бреак::
CommandHelper()
Goto ПоставитьБарикаду

::/dbreak::
::.викуфл::
::.дбреак::
CommandHelper()
Goto УбратьБарикаду

::допрос-миранда::
CommandHelper()
Goto ДопросМиранда

::допрос-начало::
CommandHelper()
Goto ДопросНачало

::допрос-прод::
CommandHelper()
Goto ДопросПродолжение

::допрос-конец::
CommandHelper()
Goto ДопросКонец

::/confidence::
::.сщташвутсу::
::.конф::
CommandHelper()
Goto Конфиденциальность

::/secret::
::.ыускуе::
::.секрет::
CommandHelper()
Goto КонфиденциальностьМаксимум

::/verbovka1::
::.мукищмлф1::
CommandHelper()
Goto ВербовкаПроверка1

::/verbovka2::
::.мукищмлф2::
CommandHelper()
Goto ВербовкаПроверка2

::/verbovka3::
::.мукищмлф3::
CommandHelper()
Goto ВербовкаПроверка3

::/verbovka4::
::.мукищмлф4::
CommandHelper()
Goto ВербовкаПроверка4

::/verbovka5::
::.мукищмлф5::
CommandHelper()
Goto ВербовкаПроверка5

::/verbovka_docs::
::.мукищмлф_вщсы::
CommandHelper()
Goto ПроверитьДокументЧеловека

::/verbovka_ok::
::.мукищмлф_щл::
CommandHelper()
Goto ВербовкаОК

::/verbovka_canc::
::.мукищмлф_сфтс::
CommandHelper()
Goto ВербовкаОтказ

::/stroy::
::.строй::
CommandHelper()
Goto Строй

::/stroy_info::
::.строй-инф::
CommandHelper()
Goto СтройИнфо

::/lec::
::.дус::
::.лек::
::.лекция::
CommandHelper()
Goto Лекция

::/training::
::.треня::
CommandHelper()
Goto Тренировка

::/invite::
::.штмшеу::
CommandHelper()
Goto Принятие

::/rang::
::.кфтп::
CommandHelper()
Goto Повышение

::/blist::
::.идшые::
CommandHelper()
Goto ЧёрныйСписок

::/verbovka_end::
::.мукищмлф_утв::
CommandHelper()
Goto ВербовкаКонец

::/hi_mo::
::.рш_ьщ::
::.докмо::
CommandHelper()
Goto ПриветствиеМО

::/hi_mvd::
::.рш_ьмв::
::.докмвд::
CommandHelper()
Goto ПриветствиеМВД

::/hi_fsin::
::.рш_аышт::
::.докфсин::
CommandHelper()
Goto ПриветствиеФСИН

::/lec_mo::
::.лекция-мо::
CommandHelper()
Goto ЛекцияМО

::/lec_mvd::
::.лекция-мвд::
CommandHelper()
Goto ЛекцияМВД

::/lec_fsin::
::.лекция-фсин::
CommandHelper()
Goto ЛекцияФСИН
#If

CommandHelper() {
    SendInput, {end}+{home}{del}
    SendInput, {esc}
    Sleep 500
}



; Сокращенный ввод

:?*:связь-мо::/d [ФСБ] - [МО] На связь...
:?*:связь-мз::/d [ФСБ] - [МЗ] На связь...
:?*:связь-мвд::/d [ФСБ] - [МВД] На связь...
:?*:связь-фсин::/d [ФСБ] - [ФСИН] На связь...
:?*:связь-пр::/d [ФСБ] - [Пра-во] На связь...
:?*:связь-мчс::/d [ФСБ] - [МЧС] На связь...
:?*:связь-трк::/d [ФСБ] - [ТРК] На связь...
:?*:насвязи-мо::/d [ФСБ] - [МО] На связи{!}
:?*:насвязи-мз::/d [ФСБ] - [МЗ] На связи{!}
:?*:насвязи-мвд::/d [ФСБ] - [МВД] На связи{!}
:?*:насвязи-фсин::/d [ФСБ] - [ФСИН] На связи{!}
:?*:насвязи-пр::/d [ФСБ] - [Пра-во] На связи{!}
:?*:насвязи-мчс::/d [ФСБ] - [МЧС] На связи{!}
:?*:насвязи-трк::/d [ФСБ] - [ТРК] На связи{!}
:?*:пон-мо::/d [ФСБ] - [МО] Приняли. Выезжаем{!}
:?*:пон-мз::/d [ФСБ] - [МЗ] Приняли. Выезжаем{!}
:?*:пон-мвд::/d [ФСБ] - [МВД] Приняли. Выезжаем{!}
:?*:пон-фсин::/d [ФСБ] - [ФСИН] Приняли. Выезжаем{!}
:?*:пон-пр::/d [ФСБ] - [Пра-во] Приняли. Выезжаем{!}
:?*:пон-мчс::/d [ФСБ] - [МЧС] Приняли. Выезжаем{!}
:?*:пон-трк::/d [ФСБ] - [ТРК] Приняли. Выезжаем{!}
:?*:напад-мо::/d [ФСБ] - [МО] Готовится нападение на ВЧ. Будьте готовы{!}
:?*:запрос-мо::/d [ФСБ] - [МО] Разрешите въезд для автомобиля с Н/З "" с целью доп. защиты?{Left 22}
:?*:заезд-мо::/d [ФСБ] - [МО] На ВЧ въезжает автомобиль с Н/З "" с целью доп. защиты{!}{Left 22}
:?*:нестрой::
SendInput, /r Не явлюсь в строй по причине:{Space}
Return



; Основное

ВводId:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {Enter}
Sleep 500
SendInput, {F6}{!}Введите id игрока для дальнейшего взаимодействия:{Space}
Input, playerId, V I M, {Enter}
SendInput, {end}+{home}{del}{esc}
Gui, 3:Destroy
SavedInfo(playerId, fakeName)
Return

ОчиститьId:
playerId := "null"
Gui, 3:Destroy
SavedInfo(playerId, fakeName)
Return

ВводНика:
SendInput, {Enter}
Sleep 500
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}{!}Введите ваше маскировочное имя:{Space}
Input, fakeName, V I M, {Enter}
SendInput, {end}+{home}{del}{esc}
SendInput, {F6}{!}Введите ваше маскировочное звание:{Space}
Input, fakeRank, V I M, {Enter}
SendInput, {end}+{home}{del}{esc}
Gui, 3:Destroy
SavedInfo(playerId, fakeName)
Return

ОчиститьНик:
fakeName := ""
fakeRank := ""
Gui, 3:Destroy
SavedInfo(playerId, fakeName)
Return

Приветствие:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Здравия желаю, вас беспокоит сотрудник Федеральной Службы Безопасности.{Enter}
Sleep 500
SendInput, {F6}/do На бронежилете висит нашивка: [ ФСБ | %department% | %rank% | %alias% ].{Enter}
Return

Нашивка:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/do На бронежилете висит нашивка: [ ФСБ | %department% | %rank% | %alias% ].{Enter}
Return

УдостоверениеФСБ:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/do Удостоверение в нагрудном кармане.{Enter}
Sleep 1000 
SendInput, {F6}/me вынул удостоверение из кармана{Enter}
Sleep 1000 
SendInput, {F6}/do Удостоверение в руке.{Enter}
Sleep 1000 
SendInput, {F6}/me легким движением открыл нужную страницу{Enter}
Sleep 1000 
SendInput, {F6}/do Удостоверение перед глазами человека.{Enter}
Sleep 200
if (playerId = "null") {
    SendInput, {F6}/doc{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/doc %playerId%{Enter}
}
Sleep 500
SendInput, {Enter}
Sleep 1000 
SendInput, {F6}/me убрал удостоверение обратно в карман{Enter}
Return

ПросьбаОстановится:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Гражданин, пожалуйста остановитесь{!}{Enter}
Sleep 1000
SendInput, {F6}Иначе сочту ваши действия как 8.4 УК{Enter}
Sleep 1000
SendInput, {F6}/do На бронежилете висит нашивка: [ ФСБ | %department% | %rank% | %alias% ].{Enter}
Return

РаботаФСБ:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/s Всем стоять, ФСБ{!} Задержание{!}{Enter}
Sleep 1000
SendInput, {F6}/s Руки за голову, на колени, лицом в пол{!}{Enter}
Sleep 1000
SendInput, {F6}/s Слова поперёк - считаю отказом подчиниться.{Enter}
Sleep 1000
SendInput, {F6}/s Не заставляйте нас применять спецсредства{!}{Enter}
Sleep 1000
SendInput, {F6}/s Задержание идёт по закону{!}{Enter}
Sleep 1000
SendInput, {F6}/n /anim 3 2{Enter}
Return

РаботаМегафонФСБ:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/m [ФСБ] Внимание, говорит ФСБ{!} Всем сесть на землю, руки за голову{!}{Enter}
Sleep 2000
SendInput, {F6}/m [ФСБ] Головы не поднимать{!} Любое движение - применение силы{!}{Enter}
Sleep 2000
SendInput, {F6}/m [ФСБ] Задержание идёт по закону{!}{Enter}
Sleep 1000
SendInput, {F6}/n /anim 3 2{Enter}
Return

ПросьбаДокументов:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6} Предъявите, пожалуйста, Ваши документы, удостоверяющие Вашу личность.{Enter}
Sleep 1000
SendInput, {F6} За отказ от предоставления документов вы будете задержаны по статье 8.4.1 УК.{Enter}
Sleep 1000
SendInput, {F6} Такой-же случай произойдет если вы не предъявите документы в течении 30 секунд.{Enter}
Sleep 1000
SendInput, {F6} Если Вы убежите или попробуете это сделать я сочту это за 8.4 УК.{Enter}
Sleep 1000
SendInput, {F6}/n /doc id - если вы в гос. структуре, /pass id - для остальных{Enter}
Return

ВзятьДокументы:
SendMessage, 0x50, 0x4190419,, A
SendInput, {F6}/yes{Enter}
Sleep 800
SendInput, {F6}/me внимательно изучил документы человека глазами{Enter}
Sleep 800
SendInput, {F6}/me достал КПК из кармана и включил его.{Enter}
Sleep 800
SendInput, {F6}/do КПК в руках.{Enter}
Sleep 800
SendInput, {F6}/me записал Имя Человека в КПК{Enter}
Sleep 800
SendInput, {F6}/me убрал КПК в карман{Enter}
Sleep 800
SendInput, {F6}/do КПК в кармане.{Enter}
Return

НачатьПогоню:
SendMessage, 0x50,, 0x4190419,, A
if(full_rp){
    SendInput, {F6}/do Рация на поясе.{Enter}
    Sleep 700
    SendInput, {F6}/me достал рацию{Enter}
    Sleep 700
    SendInput, {F6}/todo Зажав кнопку*Прием, это %alias%, преследую преступника.{Enter}
    Sleep 500
}
if (playerId = "null") {
    SendInput, {F6}/pg{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/pg %playerId%{Enter}
}
Return

Арест:
SendMessage, 0x50,, 0x4190419,, A
if(full_rp){
    SendInput, {F6}/do Наручники свисают с пояса. {Enter}
    Sleep 900
    SendInput, {F6}/me снял наручники с пояса{Enter}
    Sleep 800
    SendInput, {F6}/do В руке наручники.{Enter}
    Sleep 800
    SendInput, {F6}/me схватил человека за руку, затем заломил руку{Enter}
    Sleep 700
    SendInput, {F6}/me заковал человека в наручники{Enter}
    Sleep 700
    SendInput, {F6}/do Процесс...{Enter}
    Sleep 650
    SendInput, {F6}/me начинает вести задержанного{Enter}
    Sleep 200
}
if (playerId = "null") {
    SendInput, {F6}/cuff{Space}
    Input, playerId, V I M, {Enter}
    Sleep 1000
    SendInput, {F6}/escort %playerId%{Enter}
    playerId := "null"
} else {
    SendInput, {F6}/cuff %playerId%{Enter}
    Sleep 1000
    SendInput, {F6}/escort %playerId%{Enter}
}
Return

ОтменаАреста:
SendMessage, 0x50,, 0x4190419,, A
if(full_rp){
    SendInput, {F6}/do Наручники на руках у человека.{Enter}
    Sleep 500
    SendInput, {F6}/me снял наручники с рук{Enter}
    Sleep 500
    SendInput, {F6}/do Наручники сняты.{Enter}
    Sleep 800
    SendInput, {F6}/me повесил наручники на пояс{Enter}
    Sleep 800
    SendInput, {F6}/do Наручники на поясе.{Enter}
    Sleep 800
    SendInput, {F6}/me взял человека за руку{Enter}
    Sleep 800
    SendInput, {F6}/me отпустил руки человеку{Enter}
    Sleep 900
    SendInput, {F6}/do Руки в свободном положение.{Enter}
    Sleep 900
    SendInput, {F6}/me перестал вести задержанного{Enter}
}
Sleep 200
if (playerId = "null") {
    SendInput, {F6}/escort{Space}
    Input, playerId, V I M, {Enter}
    Sleep 1000
    SendInput, {F6}/uncuff %playerId%{Enter}
    playerId := "null"
} else {
    SendInput, {F6}/escort %playerId%{Enter}
    Sleep 1000
    SendInput, {F6}/uncuff %playerId%{Enter}
}
Return

Обыск:
SendMessage, 0x50,, 0x4190419,, A
if(full_rp){
    date = %A_DD%.%A_MM%.%A_YYYY%
    SendInput, {F6}Сейчас я проведу обыск, просьба не двигаться. {Enter}
    Sleep 700
    SendInput, {F6}/me протянул руку в карман, затем взял Ордер {Enter}
    Sleep 900
    SendInput, {F6}/do Достал ордер на обыск от %date%, Подпись: Губернатор Н.О.{Enter}
    Sleep 900
    SendInput, {F6}/me показал документ человеку напротив{Enter}
    Sleep 700
    SendInput, {F6}/do Перчатки с надписью "ФСБ" на руках.{Enter}
    Sleep 800
    SendInput, {F6}/me начал ощупывать человека напротив{Enter}
    Sleep 800
    SendInput, {F6}/do Верхняя часть осмотрена.{Enter}
    Sleep 800
    SendInput, {F6}/me начал щупать в области ног{Enter}
    Sleep 800
    SendInput, {F6}/do Нижняя часть осмотрена.{Enter}
    Sleep 800
    SendInput, {F6}/me усмехнулся{Enter}
}
Sleep 800
if (playerId = "null") {
    SendInput, {F6}/search{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/search %playerId%{Enter}
}
Return

НайденаЗапрещенка:
SendMessage, 0x50, 0x4190419,, A
SendInput, {F6}Так так так... Что тут у нас?{Enter}
Sleep 800
SendInput, {F6}/me нашупал подозрительный предмет{Enter}
Sleep 800
SendInput, {F6}/me достал его из карманов подозреваемого{Enter}
Sleep 800
SendInput, {F6}/do ZIP пакет в руках.{Enter}
Sleep 800
SendInput, {F6}/me аккуратно убрал предмет в пакет{Enter}
Sleep 800
SendInput, {F6}/me запечатал пакет и убрал в рюкзак{Enter}
Sleep 800
SendInput, {F6}/do ZIP пакет в рюкзаке.{Enter}
Return

ОбыскДоков:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Такс... Где тут Ваши документы?{Enter}
Sleep 700
SendInput, {F6}/me начал ощупывать карманы человека {Enter}
Sleep 900
SendInput, {F6}/do Процесс...{Enter}
Sleep 900
SendInput, {F6}/do Папка с документами найдена.{Enter}
Sleep 800
SendInput, {F6}/me вытащил папку из кармана{Enter}
Sleep 800
SendInput, {F6}/do Папка в руках.{Enter}
Sleep 800
SendInput, {F6}/me начал изучать документы и заполнять информацию в КПК{Enter}
Sleep 800
SendInput, {F6}/do Информация получена.{Enter}
if (playerId = "null") {
    SendInput, {F6}/checkdocs{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/checkdocs %playerId%{Enter}
}
Return

ОбыскБагажника:
SendMessage, 0x50, 0x4190419,, A
SendInput, {F6}/do Багажник закрыт.{Enter}
Sleep 800
SendInput, {F6}/me дергнул багажник и открыл его{Enter}
Sleep 800
SendInput, {F6}/do Багажник открыт.{Enter}
Sleep 800
SendInput, {F6}/me начал аккуратно рассматривать содержимое багажника {Enter}
Sleep 800
SendInput, {F6}/do Процесс...{Enter}
Sleep 800
SendInput, {F6}/do Багажник осмотрен.{Enter}
Return

СнятьАксессуары:
SendMessage, 0x50, 0x4190419,, A
SendInput, {F6}/do Маска на лице человека.{Enter}
Sleep 800
SendInput, {F6}/me снял маску и другие аксессуары с лица человека{Enter}
Sleep 800
SendInput, {F6}/anim 6 7{Enter}
Sleep 800
SendInput, {F6}/do Маска снята.{Enter}
Sleep 800
SendInput, {F6}/me положил маску в рюкзак с шевроном "ФСБ" {Enter}
Sleep 800
SendInput, {F6}/do Лицо человека полностью видно.{Enter}
Return

Фоторобот:
SendMessage, 0x50, 0x4190419,, A
SendInput, {F6}/me движением рук достал из кармана Apple iPad Pro и стилус{Enter}
Sleep 850
SendInput, {F6}/do Apple iPad Pro и стилус в руках.{Enter}
Sleep 850
SendInput, {F6}/me движением пальц перешел во вкладку рисовать{Enter}
Sleep 850
SendInput, {F6}/me движением рук нарисовал фоторобот подозреваемого{Enter}
Sleep 850
SendInput, {F6}/me движением рук достал переходник и КПК из кармана{Enter}
Sleep 850
SendInput, {F6}/do Переходник и КПК в руках.{Enter}
Sleep 850
SendInput, {F6}/me движением рук подключил переходник к КПК и iPad{Enter}
Sleep 850
SendInput, {F6}/me движением пальц перекинул фоторобот подозреваемого в КПК {Enter}
Sleep 850
SendInput, {F6}/do Фоторобот подозреваемо находиться в КПК.{Enter}
Sleep 850
SendInput, {F6}/me движением пальц зашел в базу данных и перекинул фоторобот подозреваемого{Enter}
Sleep 850
SendInput, {F6}/me нажал кнопку поиск{Enter}
Sleep 850
SendInput, {F6}/do Через несколько секунд личность человека была установлена.{Enter}
Sleep 850
Return

ЧеловекОтпечатки:
SendMessage, 0x50, 0x4190419,, A
SendInput,{Enter}
Sleep 500
SendInput, {F6}/do Аппарат "CТОЛ" в кармане.{Enter}
Sleep 700
SendInput, {F6}/me резким движением достал Аппарат{Enter}
Sleep 700
SendInput, {F6}/do Аппарат "СТОЛ" в руке.{Enter}
Sleep 700
SendInput, {F6}/me резким движением потянул руку гражданина напротив и приложил его палец к аппарату{Enter}
Sleep 700
SendInput, {F6}/do Процесс сканирования начат.{Enter}
Sleep 700
SendInput, {F6}/do Процесс завершен.{Enter}
Sleep 700
SendInput, {F6}/do Личность установлена. {Enter}
Sleep 700
SendInput, {F6}/me достал КПК из кармана и ввел данные из аппарата{Enter}
Sleep 700
SendInput, {F6}/do Человек найден в базе данных. {Enter}
Return

ЧеловекНЗ:
SendMessage, 0x50, 0x4190419,, A
SendInput, {F6}/me движением рук достал КПК и включил его{Enter}
Sleep 750
SendInput, {F6}/do КПК включен.{Enter}
Sleep 750
SendInput, {F6}/me движением пальцев нажал на пункт "База данных МВД"{Enter}
Sleep 750
SendInput, {F6}/me ловким движением пальцев ввел номер автомобиля{Enter}
Sleep 750
SendInput, {F6}/do Через какой то промежуток времени КПК показал досье водителя.{Enter}
Sleep 750
SendInput, {F6}/do Личность водителя установлена.{Enter}
Return

Розыск:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me перешел в вкладку "Розыск" в своем КПК{Enter}
Sleep 700
SendInput, {F6}/do Вкладка загружена.{Enter}
Sleep 700
SendInput, {F6}/me нажал кнопку "Объявить в розыск"{Enter}
Sleep 700
SendInput, {F6}/me ввел всю информацию про подозреваемого{Enter}
Sleep 700
SendInput, {F6}/do Человек объявлен в розыск.{Enter}
Sleep 700
if (playerId = "null") {
    SendInput, {F6}/su{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/su %playerId%{Space}
}
Return

Штраф:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/do КПК в руках.{Enter}
Sleep 700
SendInput, {F6}/me нажал на пункт "Выписать штраф в электронном виде"{Enter}
Sleep 800
SendInput, {F6}/do Гражданину пришел штраф в приложении телефона.{Enter}
Sleep 700
if (playerId = "null") {
    SendInput, {F6}/ticket{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/ticket %playerId%{Space}
}
Return

ЗабратьЛицензию:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me перешел в вкладку "Аннулировать лицензию" в своем КПК{Enter}
Sleep 700
SendInput, {F6}/do Вкладка загружена.{Enter}
Sleep 700
SendInput, {F6}/me ввел номер лицензии и данные человека{Enter}
Sleep 700
SendInput, {F6}/me забрал лицензию у человека{Enter}
Sleep 700
SendInput, {F6}/do Лицезия аннулирована.{Enter}
Sleep 700
if (playerId = "null") {
    SendInput, {F6}/takelic{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/takelic %playerId%{Enter}
}
Return

СнятьРозыск:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me взял рацию в руки, затем зажал кнопку{Enter}
Sleep 900
SendInput, {F6}/do Кнопка зажата.{Enter}
Sleep 900
SendInput, {F6}/me сообщил данные подозреваемого диспетчеру{Enter}
Sleep 900
SendInput, {F6}/do Данные сообщены диспетчеру.{Enter}
Sleep 900
SendInput, {F6}/do Диспетчер: С подозреваемого снят розыск.{Enter}
Sleep 900
if (playerId = "null") {
    SendInput, {F6}/clear{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/clear %playerId%{Enter}
}
Return

ВыкинутьИзАвто:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/ejectout{Enter}
Input, tempId, V I M, {Enter}
Return

ПосадитьВАвто:
SendMessage, 0x50,, 0x4190419,, A
if(full_rp){
    SendInput, {F6}/me открыл дверь автомобиля{Enter}
    Sleep 1000
    SendInput, {F6}/do Дверь открыта.{Enter}
    Sleep 1000
    SendInput, {F6}/me пригнув голову преступника посадил его в автомобиль{Enter}
    Sleep 1000
    SendInput, {F6}/do Процесс...{Enter}
    Sleep 1000
    SendInput, {F6}/me закрыл дверь{Enter}
    Sleep 1000
    SendInput, {F6}/do Дверь закрыта.{Enter}
}
if (playerId = "null") {
    SendInput, {F6}/putpl{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/putpl %playerId%{Enter}
}
Return

ВыломатьДверь:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me начал выбивать дверь{Enter}
Sleep 700
SendInput, {F6}/do Процесс...{Enter}
Sleep 700
SendInput, {F6}/me выбивает дверь{Enter}
Sleep 700
SendInput, {F6}/break_door{Enter}
Return

ЗачитатьПрава:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Вы имеете право хранить молчание.{Enter}
Sleep 1000
SendInput, {F6}Всё, сказанное Вами, может и будет использовано против Вас в суде.{Enter}
Sleep 1000
SendInput, {F6}Вы имеете право обжаловать мои действия в суде...{Enter}
Sleep 1000
SendInput, {F6}или иных инстанциях если не согласны с нарушением.{Enter}
Sleep 1000
SendInput, {F6}Так-же Вы имеете право на адвоката. Вам нужен адвокат?{Enter}
Return

НеАдвокат:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Причина (1 - их нету, 2 - занят, 3 - не ответил):{Space}
Input, reason, V I M, {Enter}
SendInput, {end}+{home}{del}{esc}
Sleep 500
if (reason = "1")
{
    SendInput, {F6}На данный момент адвоката нет в области{Enter}
    Sleep 1000
    SendInput, {F6}Ваше право на адвоката является реализованным.{Enter}
    Sleep 1000
    SendInput, {F6}/n /adlist -> для проверки.{Enter}
}
else if (reason = "2")
{
    SendInput, {F6}На данный момент все адвокаты заняты и не могут приехать.{Enter}
    Sleep 1000
    SendInput, {F6}Ваше право на адвокатаявляется реализованным.{Enter}
}
else if (reason = "3")
{
    SendInput, {F6}Увы, адвокат не ответил в установленное время.{Enter}
    Sleep 1000
    SendInput, {F6}Ваше право на адвоката является реализованным.{Enter}
}
Return

ВызватьАдвоката:
SendMessage, 0x50,, 0x4190419,, A
if(full_rp){
    SendInput, {F6}/do Рация на поясе.{Enter}
    Sleep 700
    SendInput, {F6}/me достал рацию{Enter}
    Sleep 700
    SendInput, {F6}/me зажал кнопку разговора{Enter}
    Sleep 700
    SendInput, {F6}/do Передал информацию в нужное место.{Enter}
    Sleep 700
}
SendInput, {F6}/d [ФСБ] - [Пра-во] Нужен адвокат в . Время на ответ: 5 минут.{Left 26}
Sleep 700
Input, tempId, V I M, {Enter}
Sleep 700
if(full_rp){
    SendInput, {F6}/me отпустил кнопку и убрал рацию{Enter}
    Sleep 700
}
SendInput, {F6}Ожидаем ответ в течении 5 минут, время пошло{Enter}
Sleep 700
SendInput, {F6}/me взглянул на часы и запомнил время{Enter}
Sleep 700
SendInput, {F6}/c 060{Enter}
Return

ОтследитьМестоположение:
SendMessage, 0x50,, 0x4190419,, A
if(full_rp){
    SendInput, {F6}/do Рация на поясе.{Enter}
    Sleep 700
    SendInput, {F6}/me достал рацию{Enter}
    Sleep 700
    SendInput, {F6}/todo Зажав кнопку*Диспетчер, прием, это %alias%.{Enter}
    Sleep 500
    SendInput, {F6}/todo Держа кнопку*Доложите пожалуйста информацию о преступнике.{Enter}
    Sleep 500
}
if (playerId = "null") {
    SendInput, {F6}/setmark{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/setmark %playerId%{Enter}
}
Return

Выговор:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me достал КПК из кармана{Enter}
Sleep 1000
SendInput, {F6}/do КПК в руках.{Enter}
Sleep 1000
SendInput, {F6}/me ввел пароль от организации в которой работает нарушитель{Enter}
Sleep 1000
SendInput, {F6}/me нашел нужного человека в списке сотрудников{Enter}
Sleep 1000
SendInput, {F6}/do Открылась информация о сотруднике.{Enter}
Sleep 1000
SendInput, {F6}/me нажал кнопку "выговоры" и ввел нужную информацию{Enter}
Sleep 1000
SendInput, {F6}/do Выговор выписан.{Enter}
Sleep 200
if (playerId = "null") {
    SendInput, {F6}/fwarn{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/fwarn %playerId%
}
Return

Уволить:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me достал КПК из кармана{Enter}
Sleep 1000
SendInput, {F6}/do КПК в руках.{Enter}
Sleep 1000
SendInput, {F6}/me ввел пароль от организации в которой работает нарушитель{Enter}
Sleep 1000
SendInput, {F6}/me нашел нужного человека в списке сотрудников{Enter}
Sleep 1000
SendInput, {F6}/do Открылась информация о сотруднике.{Enter}
Sleep 1000
SendInput, {F6}/me нажал кнопку "Уволить" и ввел нужную информацию{Enter}
Sleep 1000
SendInput, {F6}/do Сотрудник уволен.{Enter}
Sleep 200
if (playerId = "null") {
    SendInput, {F6}/uninvite {Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/uninvite %playerId%
}
Return

НачатьПрослушку:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/do Наушники лежат на панели.{Enter}
Sleep 1000
SendInput, {F6}/me надел их на голову{Enter}
Sleep 1000
SendInput, {F6}/do Наушники надеты.{Enter}
Sleep 1000
SendInput, {F6}/me начал вводить что-то в компьютер{Enter}
Sleep 1000
SendInput, {F6}/do Процесс...{Enter}
Sleep 1000
SendInput, {F6}/do Прослушка подключена.{Enter}
Sleep 1000
SendInput, {F6}/me %name% начал слушать разговор {Enter}
Return

ПоставитьБарикаду:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/do Объект в руках.{Enter}
Sleep 700
SendInput, {F6}/me поставил его на землю{Enter}
Sleep 700
SendInput, {F6}/do Объект установлен.{Enter}
Sleep 700
SendInput, {F6}/brea{k}{Space}
Return

УбратьБарикаду:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/do Объект на земле.{Enter}
Sleep 700
SendInput, {F6}/me взял объект в руки{Enter}
Sleep 700
SendInput, {F6}/do Объект в руках.{Enter}
Sleep 700
SendInput, {F6}/me убрал его в багажник автомобиля{Enter}
Sleep 700
SendInput, {F6}/dbreak{Space}
Return

Конфиденциальность:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me изъял все звукозаписывающие устройства у человека напротив{Enter}
Sleep 500
SendInput, {F6}/do Устройства изъяты. {Enter}
Sleep 500
SendInput, {F6}/me забрал скрытую камеру у человека напротив{Enter}
Sleep 500
SendInput, {F6}/do Камера изъята. {Enter}
Sleep 500
Return

КонфиденциальностьМаксимум:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me включил прибор создание помех радио/телефоно технике{Enter}
Sleep 1000
SendInput, {F6}/do Прибор включен. {Enter}
Sleep 1000
SendInput, {F6}/me включил прибор создания помех видео/аудио съемке{Enter}
Sleep 1000
SendInput, {F6}/do Прибор включен.{Enter}
Sleep 1000
SendInput, {F6}/do В автомобиле заглушены телефон/камеры/аудиодиктофоны.{Enter}
Sleep 1000
SendInput, {F6}/me отключил КПК, нагрудную камеру, бортовой компьютер{Enter}
Sleep 1000
SendInput, {F6}/do Автомобиль полностью заглушен от прослушки.{Enter}
Sleep 1000
SendInput, {F6}/me закрыл окна,двери{Enter}
Sleep 1000
SendInput, {F6}/me надел перчатки{Enter}
Sleep 1000
SendInput, {F6}/do Перчатки надеты.{Enter}
Sleep 1000
SendInput, {F6}/do В автомобиле стоят шторы закрывающий обзор третьим лицам.{Enter}
Sleep 1000
SendInput, {F6}/me нашел экшн камеру у человека напротив{Enter}
Sleep 1000
SendInput, {F6}/do Экшн камера на человеке.{Enter}
Sleep 1000
SendInput, {F6}/me сорвал экшн камеру у человека напротив{Enter}
Sleep 1000
SendInput, {F6}/do Экшн камера в руках.{Enter}
Sleep 1000
SendInput, {F6}/me выключил видео/аудио запись{Enter}
Sleep 1000
SendInput, {F6}/do Экшн камера выключена.{Enter}
Sleep 1000
SendInput, {F6}/do Микрофон в ухе у человека напротив.{Enter}
Sleep 1000
SendInput, {F6}/me снял микрофон с уха.{Enter}
Sleep 1000
SendInput, {F6}/do Микрофон в руках.{Enter}
Sleep 1000
SendInput, {F6}/me выключил микрофон{Enter}
Sleep 1000
SendInput, {F6}/do Микрофон выключен.{Enter}
Sleep 1000
SendInput, {F6}/me незаметным движением руки выключил камеру у напарника{Enter}
Sleep 1000
SendInput, {F6}/do Камера выключена.{Enter}
Sleep 1000
SendInput, {F6}/me начал шептаться с человеком напротив{Enter}
Return

; Допрос

ДопросМиранда:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Перед началом допроса сообщаю Вам о ваших правах:{Enter}
Sleep 1000
SendInput, {F6}Вы имеете право хранить молчание.{Enter}
Sleep 1000
SendInput, {F6}Всё, сказанное Вами, может и будет использовано против Вас в суде.{Enter}
Sleep 1000
SendInput, {F6}Вы имеете право обжаловать мои действия в суде...{Enter}
Sleep 1000
SendInput, {F6}или иных инстанциях если не согласны с нарушением.{Enter}
Sleep 1000
SendInput, {F6}Так-же Вы имеете право на адвоката. Вам нужен адвокат?{Enter}
Return

ДопросНачало:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Думаю можем приступать к допросу.{Enter}
Sleep 700
SendInput, {F6}Перед началом хочу Вас предупредить о том, что:{Enter}
Sleep 700
SendInput, {F6}Во-первых, ведется видеофиксация нашего разговора.{Enter}
Sleep 700
SendInput, {F6}Во-вторых, дачей ложных сведений Вы подставляете только себя.{Enter}
Sleep 700
SendInput, {F6}Итак, начнём{!} Ранее мною моя личность была обозначена.{Enter}
Sleep 700
SendInput, {F6}Теперь мне требуется полная информация о Вас, а именно:{Enter}
Sleep 700
SendInput, {F6}ФИО, звание, должность, место проживание, сколько вам лет{Enter}
Sleep 700
SendInput, {F6}И сколько вы проживаете в области?{Enter}
Return

ДопросПродолжение:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/do Чистый бланк допроса, находится на столе.{Enter}
Sleep 700
SendInput, {F6}/me ловким движением руки, подтягивает к себе бланк допроса, так-же ручку{Enter}
Sleep 700
SendInput, {F6}/do Ручка в руке.{Enter}
Sleep 700
SendInput, {F6}/do Бланк допроса на столе.{Enter}
Sleep 700
SendInput, {F6}/me начинает заполнять бланк{Enter}
Sleep 700
SendInput, {F6}/do Процесс...{Enter}
Sleep 700
SendInput, {F6}/todo Записав всю информацию*Отлично, переходим дальше.{Enter}
Return

ДопросКонец:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me записал всю информацию о деле{Enter}
Sleep 700
SendInput, {F6}/do Папка на столе.{Enter}
Sleep 700
SendInput, {F6}/me закрыл папку с делом{Enter}
Sleep 700
SendInput, {F6}/do Папка закрыта.{Enter}
Sleep 700
SendInput, {F6}Хорошо, на этом мы закончим наш допрос.{Enter}
Sleep 700
SendInput, {F6}Мы выяснили все, что нам было необходимо.{Enter}
Sleep 700
SendInput, {F6}Наше решение:{Space}
Return

ВербовкаПроверка1:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/n Сейчас я буду просить ваши документы.{Enter}
Sleep 700
SendInput, {F6}/n Все что от Вас требуется - показать их мне, отыгрывая РП{Enter}
Sleep 700
SendInput, {F6}/n Все стандартно, можно использовать АХК.{Enter}
Sleep 700
SendInput, {F6}Будьте добры предоставить своё служебное удостоверение.{Enter}
Sleep 700
SendInput, {F6}/n /doc id{Enter}
Return

ВербовкаПроверка2:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Хорошо, дальше покажите мне Ваш паспорт.{Enter}
Sleep 700
SendInput, {F6}/n /pass id{Enter}
Return

ВербовкаПроверка3:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Отлично, теперь мне требуется Ваша мед. карта.{Enter}
Sleep 700
SendInput, {F6}/n /showmc id{Enter}
Return

ВербовкаПроверка4:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Так, и на последок - покажите мне Ваши лицензии.{Enter}
Sleep 700
SendInput, {F6}/n /lic id{Enter}
Return

ВербовкаПроверка5:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/n Последнее что нужно /team_history id | Без РП{Enter}
Return

ВербовкаОК:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Отлично, ожидайте нашего решения...{Enter}
Return

ВербовкаОтказ:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Увы, Вы нам не подходите, но у Вас еще всё впереди{!}{Enter}
Return

ПроверитьДокументЧеловека:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/me взглянул на документ человека{Enter}
Sleep 700
SendInput, {F6}/me внимательно осмотрел его{Enter}
Sleep 700
SendInput, {F6}/do Документ осмотрен.{Enter}
Sleep 700
SendInput, {F6}/me сверил номер документа с электронной базой данных в КПК{Enter}
Return

; Для строя

Строй:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Кого собираем:{Space}
Input, who, V I M, {Enter}
SendInput, {end}+{home}{del}{esc}
Sleep 500
SendInput, {F6}Время на сбор:{Space}
Input, time, V I M, {Enter}
SendInput, {end}+{home}{del}{esc}
Sleep 500
if (who = "")
{
    index := 0
    Loop, %time%
    {
        left_time := time - index
        min_word := GetMinuteWord(left_time)
        SendInput,{F6}/r Строй на плацу, готовность %left_time% %min_word%{!}{Enter}
        index++
        Sleep 60000
    }

} else {
    index := 0
    Loop, %time%
    {
        left_time := time - index
        min_word := GetMinuteWord(left_time)
        SendInput,{F6}/r Отдел %who%, строй на плацу, готовность %left_time% %min_word%{!}{Enter}
        index++
        Sleep 60000
    }
}

Return


СтройИнфо:
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/n Перед началом хочу вам напомнить что нужно для того, что бы вам засчитали отчет:{Enter}
Sleep 1000
SendInput,{F6}/n 1. С Спец. Операции (РП) требуется не менее 5 скринов{Enter}
Sleep 1000
SendInput,{F6}/n Начало | Середина (должно быть видно 5 отыгровок от вас) | Конец.{Enter}
Sleep 1000
SendInput,{F6}/n 2. С тренировки нужно 3+ скринов.{Enter}
Sleep 1000
SendInput,{F6}/n Начало | середина (несколько упражнений) | Конец.{Enter}
Sleep 1000
SendInput,{F6}/n 3. С лекции требуется всего 1 скрин. (Желательно конец){Enter}
Sleep 1000
SendInput,{F6}/n Концом РП и тренировки являются слова от проводящего строй...{Enter}
Sleep 1000
SendInput,{F6}/n Что тренировка окончена / Спец. задание все выполнили.{Enter}
Sleep 1000
SendInput,{F6}/n 4. Все скрины должны быть сделаны с /c 060{Enter}
Sleep 1000
SendInput,{F6}/n Спасибо за внимание, переходим к строю...{Enter}
Return

Тренировка:
SendMessage, 0x50,, 0x4190419,, A
Random, exercise1, 10000, 100000
Random, exercise2, 10000, 100000
SendInput, {F6}/s Перейдем к тренировке{!}{Enter}
Sleep 1000
SendInput, {F6}/s Начнём её с %exercise1% отжиманий.{Enter}
Sleep 1000
SendInput, {F6}/n /anim 6 23 | Примечание: Хасл не делают{Enter}
Sleep 120000
SendInput, {F6}/s Отставить{!}{Enter}
Sleep 1000
SendInput, {F6}/s Дальше делаем %exercise2% приседаний{!}{Enter}
Sleep 1000
SendInput, {F6}/n Нажимайте клавишу "C" или же /anim 3 2{Enter}
Sleep 60000
SendInput, {F6}/s Отставить{!}{Enter}
Sleep 1000
SendInput, {F6}/s Закончим тренировку легкой медитацией{!}{Enter}
Sleep 1000
SendInput, {F6}/n /anim 8 2{Enter}
Sleep 120000
SendInput, {F6}/s Отставить{!}{Enter}
Sleep 1000
SendInput, {F6}/s Тренировка окончена. Не расходимся{!}{Enter}
Return

Лекция:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Номер лекции (0 - рандом, 1-4, 5 - верба):{Space}
Input, num, V I M, {Enter}
SendInput, {end}+{home}{del}{esc}
Sleep 500
if (num = 0 or num = "")
{
    Random, num, 1, 4
    lec := "Лекция" num
    Goto %lec%
} if (num = 5)
{
    GoTo ЛекцияФСБ
} else {
    lec := "Лекция" num
    Goto %lec%
}

Лекция1:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/s Уважаемые сотрудники ФСБ{!}{Enter}
Sleep 1000
SendInput, {F6}/s Сейчас я проведу лекцию на тему "Отделы ФСБ".{Enter}
Sleep 1000
SendInput, {F6}/s  Отдел по Борьбе с Терроризмом или ОБТ, главная задача:{Enter}
Sleep 1000
SendInput, {F6}/s Основная боевая ячейка ФСБ, деятельностью которой является поимка преступников{Enter}
Sleep 1000
SendInput, {F6}/s и содействие МВД в этом, а также;преимущественно поимка особо опасных преступников{Enter}
Sleep 1000
SendInput, {F6}/n (4 - 6 звезд){Enter}
Sleep 1000
SendInput, {F6}/s Среди первостепенных задач - освобождение заложников и ликвидация террористов{Enter}
Sleep 1000
SendInput, {F6}/s Отдел по Борьбе с Коррупцией или ОБК, главная задача: контроль за превышением{Enter}
Sleep 1000
SendInput, {F6}/s должностных полномочий, а так же пресечение получения взяток сотрудниками.{Enter}
Sleep 1000
SendInput, {F6}/s Помимо вышесказанного - отдел занимается пресечением{Enter}
Sleep 1000
SendInput, {F6}/s нарушения Устава и иного законодательства государственными служащими.{Enter}
Sleep 1000
SendInput, {F6}/s Оперативно-Розыскной Отдел или ОРО - Основным родом деятельности данного отдела,{Enter}
Sleep 1000
SendInput, {F6}/s является разведка и вербовка. Разведка ведётся за гражданами, криминалом, а также{Enter}
Sleep 1000
SendInput, {F6}/s за государственными служащими. Методы: Слежка, включая наружное наблюдение,{Enter}
Sleep 1000
SendInput, {F6}/s прослушка раций и телефонов, установка GPS-трекеров на транспорт и{Enter}
Sleep 1000
SendInput, {F6}/s  отслеживание передвижения целей на транспортных средствах.{Enter}
Sleep 1000
SendInput, {F6}/s Для вербовок используется маскировка криминала и государственных ведомств.{Enter}
Sleep 1000
SendInput, {F6}/s Прежде всего собирается характеристика на кандидатов в ряды ФСБ, подаётся{Enter}
Sleep 1000
SendInput, {F6}/s на официальный портал, где Командир и Заместитель отдела ОРО пишет заключение.{Enter}
Sleep 1000
SendInput, {F6}/s Генерал ФСБ одобряет/подтверждает или отказывает заключения руководства ОРО. {Enter}
Sleep 1000
SendInput, {F6}/s Маскировка отдела ОБТ: Гражданская.{Enter}
Sleep 1000
SendInput, {F6}/s Маскировка отдела ОБК: Государственные ведомства.{Enter}
Sleep 1000
SendInput, {F6}/s Маскировка отдела ОРО: Криминальная и государственные ведомства.{Enter}
Sleep 1000
SendInput, {F6}/s Помните - маскировку, фургон прослушки и иные спец. средства...{Enter}
Sleep 1000
SendInput, {F6}/s нельзя использовать в личных целях. Фургон прослушки только для отдела ОРО.{Enter}
Sleep 1000
SendInput, {F6}/s Пункт Устава ФСБ:{Enter}
Sleep 1000
SendInput, {F6}/s 2.15 Использовать специальные средства, маскировку, специальные{Enter}
Sleep 1000
SendInput, {F6}/s электронные средства наблюдения в личных целях - {Enter}
Sleep 1000
SendInput, {F6}/s ФСБ тесно сотрудничает с иными государственными ведомствами и в частности{Enter}
Sleep 1000
SendInput, {F6}/s силовыми структурами. ФСБ вправе задействовать иные гос. ведомства{Enter}
Sleep 1000
SendInput, {F6}/s Сотрудники всех отделов обязаны соблюдать кодекс профессиональной этики,{Enter}
Sleep 1000
SendInput, {F6}/s честь, совесть, Устав ФСБ, УК, КоАП, ПДД и иное законодательство. {Enter}
Sleep 1000
SendInput, {F6}/s Сотрудники ФСБ обязаны помогать гражданам и не оставлять в опасности.{Enter}
Sleep 1000
SendInput, {F6}/s Лекция на тему "Отделы ФСБ" окончена. Спасибо за внимание.{Enter}
Sleep 1000
Return

Лекция2:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/s Сейчас я расскажу вам как вести себя сотруднику ФСБ с гражданскими.{Enter}
Sleep 1000
SendInput, {F6}/s Общение исключительно на "Вы", без мата и оскорблений.{Enter}
Sleep 1000
SendInput, {F6}/s При этом вы должны убрать оружие, не нужно пугать или проявлять агрессию.{Enter}
Sleep 1000
SendInput, {F6}/s Внимательно выслушайте гражданина и попытайтесь решить его проблему.{Enter}
Sleep 1000
SendInput, {F6}/s Старайтесь избежать конфликтов, если таковые могут возникнуть.{Enter}
Sleep 1000
SendInput, {F6}/s Но если все-таки гражданин начал хамить, кричать и драться, то:{Enter}
Sleep 1000
SendInput, {F6}/s Просите прекратить противоправное поведение{Enter}
Sleep 1000
SendInput, {F6}/s В случае неподчинения разрешено применить силу, спецсредства{Enter}
Sleep 1000
SendInput, {F6}/s Не нужно начинать диалог с гражданами, пытаясь себя возвысить{Enter}
Sleep 1000
SendInput, {F6}/s Не будьте равнодушными к бедам граждан и сохраняйте честь офицера.{Enter}
Sleep 1000
SendInput, {F6}/s Запрещено стрелять, кричать и бить людей без причины, нарушать законы.{Enter}
Sleep 1000
SendInput, {F6}/s За это вы будете уволены и занесены в ЧС ФСБ.{Enter}
Sleep 1000
SendInput, {F6}/s Надеюсь все поняли главные принципы общения с гражданскими.{Enter}
Sleep 1000
SendInput, {F6}/s Лекция на тему "Поведение с гражданскими" окончена. Спасибо за внимание.{Enter}
Return

Лекция3:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/s Здравия желаю, коллеги сейчас я проведу вам лекцию.{Enter}
Sleep 1000
SendInput, {F6}/s Лекция на тему "Правила поведения на тренировке".{Enter}
Sleep 1000
SendInput, {F6}/s С самого начала я хочу сказать что такое тренировка...{Enter}
Sleep 1000
SendInput, {F6}/s Тренировка-это осмысленная физическая деятельность, направленная на развитие силы...{Enter}
Sleep 1000
SendInput, {F6}/s выносливости, ловкости, скорости и других физических и психологических навыков.{Enter}
Sleep 1000
SendInput, {F6}/s Правила поведения на тренировке:{Enter}
Sleep 1000
SendInput, {F6}/s 1. Подчиняться проводящему строй и старшим по званию{Enter}
Sleep 1000
SendInput, {F6}/s 2. Доставать оружие только по приказу.{Enter}
Sleep 1000
SendInput, {F6}/s 3. Не покидать строй, только по приказу.{Enter}
Sleep 1000
SendInput, {F6}/s 4. В строю молчать, слушать что говорит проводящий строй.{Enter}
Sleep 1000
SendInput, {F6}/s 5. Подчиняться только проводящему строй и ст.составу.{Enter}
Sleep 1000
SendInput, {F6}/s 6. Тренировку можно начать со звания Майор.{Enter}
Sleep 1000
SendInput, {F6}/s 7. Вы должны четко и внимательно слушать ст.состав.{Enter}
Sleep 1000
SendInput, {F6}/s 8.Если вы будете спать в строю вам будут давать выговор.{Enter}
Sleep 1000
SendInput, {F6}/n Афк более 1 минуты в строю - выговор.{Enter}
Sleep 1000
SendInput, {F6}/s 9.Если вы устали, вы можете подойти к тому кто организовал тренировку...{Enter}
Sleep 1000
SendInput, {F6}/s И попросить отдохнуть.{Enter}
Sleep 1000
SendInput, {F6}/s 10. В строю запрещено использовать телефон и рацию.{Enter}
Sleep 1000
SendInput, {F6}/s 11. С разрешения проводящего строй и выше, вы можете не являться на тренировку.{Enter}
Sleep 1000
SendInput, {F6}/s А на этом наша лекция подошла к концу.{Enter}
Sleep 1000
SendInput, {F6}/s Лекция на тему "Правила поведения на тренировке" - Закончена{!} Спасибо за внимание.{Enter}
Return

Лекция4:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/s Здравия желаю, сейчас я проведу лекцию, что запрещено сотрудникам ФСБ{Enter}
Sleep 1000
SendInput, {F6}/s Сотрудникам ФСБ запрещено:{Enter}
Sleep 1000
SendInput, {F6}/s Допускать утрату оружия, транспорта и любого иного ведомственного имущества.{Enter}
Sleep 1000
SendInput, {F6}/s Допускать распространение служебной, военной, государственной тайны.{Enter}
Sleep 1000
SendInput, {F6}/s Обсуждать вопросы, связанные с присвоением званий и должностей.{Enter}
Sleep 1000
SendInput, {F6}/s Самовольно покидать территорию ведомства, не в целях несения службы.{Enter}
Sleep 1000
SendInput, {F6}/s Доставать и применять оружие без законных оснований.{Enter}
Sleep 1000
SendInput, {F6}/s Допускать проникновение неучтенных лиц на закрытую территорию ведомства.{Enter}
Sleep 1000
SendInput, {F6}/s Хранить и употреблять наркотики.{Enter}
Sleep 1000
SendInput, {F6}/s Сотрудничать с криминалом{Enter}
Sleep 1000
SendInput, {F6}/s Стрелять по другим сотрудникам ФСБ. Если это не пейнтбол.{Enter}
Sleep 1000
SendInput, {F6}/s Спорить со старшими по званию, не выполнять приказы, нарушать данный Устав.{Enter}
Sleep 1000
SendInput, {F6}/s Многократно выпрашивать о повышении.{Enter}
Sleep 1000
SendInput, {F6}/s Самовольно оставлять пост или прекращать выполнять приказ{Enter}
Sleep 1000
SendInput, {F6}/s Передавать патроны кому-либо, кроме сослуживцев.{Enter}
Sleep 1000
SendInput, {F6}/s Портить государственные транспортные средства.{Enter}
Sleep 1000
SendInput, {F6}/s Отдыхать или спать в неположенном месте. Разрешено отдыхать только в раздевалке.{Enter}
Sleep 1000
SendInput, {F6}/s Если вы спите на посту, плацу{!} Вам будет выдан выговор{!}{Enter}
Sleep 1000
SendInput, {F6}/s Лекция на тему "Что запрещено сотрудникам ФСБ" - Закончена{!} Спасибо за внимание.{Enter}
Return

; Старший Состав

Принятие:
if (rank="Полковник" or rank="Генерал")
{
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {F6}/do Рюкзак весит на спине.{Enter}
    Sleep 800
    SendInput, {F6}/do Новая форма в рюкзаке.{Enter}
    Sleep 800
    SendInput, {F6}/me начал снимать рюкзак{Enter}
    Sleep 800
    SendInput, {F6}/do Рюкзак в левой руке.{Enter}
    Sleep 800
    SendInput, {F6}/me раскрыл рюкзак, после чего взял новую форму{Enter}
    Sleep 900
    SendInput, {F6}/do Процесс ...{Enter}
    Sleep 800
    SendInput, {F6}/do Форма в правой руке.{Enter}
    Sleep 800
    SendInput, {F6}/me передал пакет с формой и рацией гражданину{Enter} 
    Sleep 1000 
    SendInput, {F6}Удачи на службе.{Enter} 
    Sleep 1000 
    SendInput, {F6}/me потянул за застежку и закрыл рюкзак{Enter}
    Sleep 800
    SendInput, {F6}/do Рюкзак в левой руке.{Enter}
    Sleep 800
    SendInput, {F6}/me одевает рюкзак за спину{Enter}
    Sleep 800
    SendInput, {F6}/do Процесс ...{Enter}
    Sleep 800
    SendInput, {F6}/do Рюкзак весит на спине.{Enter}
    Sleep 800
    SendInput, {F6}/invite{Space}
} else {
    StateInfo("Вам не доступна данная функция!","FF0000")
}
Return

Повышение:
if (rank="Полковник" or rank="Генерал")
{
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {F6}/me сорвал погоны у человека напротив.{Enter}
    Sleep 600
    SendInput, {F6}/do Погоны сорваны.{Enter}
    Sleep 600
    SendInput, {F6}/do Новые погоны в кармане.{Enter}
    Sleep 600
    SendInput, {F6}/me достал новые погоны{Enter}
    Sleep 600
    SendInput, {F6}/do Новые погоны в руке.{Enter}
    Sleep 600
    SendInput, {F6}/me передал погоны человеку напротив.{Enter}
    Sleep 800
    SendInput, {F6}/do Процесс...{Enter}
    Sleep 800
    SendInput, {F6}/do Погоны переданы.{Enter}
    Sleep 900
    SendInput, {F6}/rang{Space}
} else {
    StateInfo("Вам не доступна данная функция!","FF0000")
}
Return

ЧёрныйСписок:
if (rank="Полковник" or rank="Генерал")
{
    SendMessage, 0x50,, 0x4190419,, A 
    SendInput, {F6}/me взял КПК из кармана в руки{Enter} 
    Sleep 1000 
    SendInput, {F6}/do КПК в руке.{Enter} 
    Sleep 1000 
    SendInput, {F6}/me зашёл в папку "Сотрудники"{Enter} 
    Sleep 1000
    SendInput, {F6}/do Процесс..{Enter} 
    Sleep 1000
    SendInput, {F6}/me выбрал папку "Черный Список"{Enter} 
    Sleep 1000
    SendInput, {F6}/do Процесс..{Enter} 
    Sleep 1000 
    SendInput, {F6}/me ввёл информацию о сотруднике{Enter} 
    Sleep 1000
    SendInput, {F6}/do Информация введена.{Enter} 
    Sleep 1000 
    SendInput, {F6}/me закрыл КПК обратно и положил в карман{Enter} 
    Sleep 1000 
    SendInput, {F6}/do КПК в кармане.{Enter} 
    Sleep 1000 
    SendInput, {F6}/blist{Space}
} else {
    StateInfo("Вам не доступна данная функция!","FF0000")
} 
Return

ЛекцияФСБ:
if (rank="Полковник" or rank="Генерал")
{
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {F6}/s Здравия желаю, уважаемые сотрудники{!} {Enter}
    Sleep 900
    SendInput, {F6}/s Федеральная Служба Безопасности(ФСБ) - это силовая государственная организация,  {Enter}
    Sleep 900
    SendInput, {F6}/s занимающаяся обеспечением безопасности и правопорядка в области.   {Enter}
    Sleep 900
    SendInput, {F6}/s Основные задачи включают борьбу с организованной преступностью,  {Enter}
    Sleep 900
    SendInput, {F6}/s терроризмом, коррупцией и другими серьезными нарушениями закона.  {Enter}
    Sleep 900
    SendInput, {F6}/s ФСБ обладает широкими полномочиями и играет ключевую роль в поддержании стабильности и законности.  {Enter}
    Sleep 900
    SendInput, {F6}/s ФСБ уполномочено: Задерживать и арестовывать, проводить обыски, изымать имущество, осуществлять допросы и опросы,  {Enter}
    Sleep 900
    SendInput, {F6}/s проводить ОРМ, контролировать соблюдение законодательства и другое.{Enter}
    Sleep 900
    SendInput, {F6}/s На этом краткое знакомство с ФСБ завершено{!}  {Enter}
} else {
    StateInfo("Вам не доступна данная функция!","FF0000")
}
Return

ВербовкаКонец:
if (rank="Полковник" or rank="Генерал")
{
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {F6}/s По личному мнению т.Генерала, никто не подходит нам{!}{Enter}
    Sleep 1000
    SendInput, {F6}/s Помните, следим за каждым и служите по чести{!}{Enter}
} else {
    StateInfo("Вам не доступна данная функция!","FF0000")
}
Return

; Функции для МО

ПриветствиеМО:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Здравия желаю, я - %fakeRank% Армии %fakeName%{!} {Enter}
Sleep 500
SendInput, {F6}/do Удостоверение в кармане.{Enter}
Sleep 500
SendInput, {F6}/me засунул руку в карман{Enter}
Sleep 500
SendInput, {F6}/me взял удостоверение{Enter}
Sleep 500
SendInput, {F6}/do Удостоверение в руках.{Enter}
Sleep 800
SendInput, {F6}/me открыл удостоверение{Enter}
Sleep 800
SendInput, {F6}/do Удостоверение открыто.{Enter}
Sleep 800
SendInput, {F6}/me показал удостоверение человеку напротив{Enter}
Sleep 800
if (playerId = "null") {
    SendInput, {F6}/doc{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/doc %playerId%{Enter}
}
Sleep 500
SendInput, {Down}{Enter}
Return

ЛекцияМО:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {Enter}
Sleep 500
SendInput, {F6}/s Уважаемые сотрудники МО{Enter}
Sleep 3000
SendInput, {F6}/s Сейчас я проведу лекцию на тему "Устав". {Enter}
Sleep 3000
SendInput, {F6}/s Устав — свод правил, регулирующих организацию и порядок... {Enter}
Sleep 3000
SendInput, {F6}/s деятельности в какой-либо определённой сфере отношений или... {Enter}
Sleep 3000
SendInput, {F6}/s какого-либо государственного органа, организаций... {Enter}
Sleep 3000
SendInput, {F6}/s предприятия, учреждения и так далее. {Enter}
Sleep 3000
SendInput, {F6}/s После того как вы будучи новобранцем прибыли на ВЧ... {Enter}
Sleep 3000
SendInput, {F6}/s Вы обязаны были в казарме выучить устав! {Enter}
Sleep 3000
SendInput, {F6}/s Незнание устава не освободит вас от ответственности {Enter}
Sleep 3000
SendInput, {F6}/s За нарушение устава вам могут выдать Выговор либо уволить из МО с занесением {Enter}
Sleep 3000
SendInput, {F6}/s В ЧС организации МО {Enter}
Sleep 3000
SendInput, {F6}/s Прошу не нарушать устав {Enter}
Sleep 3000
SendInput, {F6}/s На этом лекция на тему "Устав" окончена. Спасибо за внимание {Enter}
Return

; Функции для МВД

ПриветствиеМВД:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Здравия желаю, вас беспокоит сотрудник МВД, %fakeRank% %fakeName%.{Enter}
Sleep 150
SendInput, {F6}/do Удостоверение в кармане.{Enter}
Sleep 150
SendInput, {F6}/me достал удостоверение из кармана и показал человеку напротив{Enter}
Sleep 150
if (playerId = "null") {
    SendInput, {F6}/doc{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/doc %playerId%{Enter}
}
Sleep 500
SendInput, {Down}{Enter}
Sleep 500
SendInput, {F6}/me убрал удостоверение в карман{Enter}
Sleep 150
SendInput, {F6}/do Удостоверение в кармане.{Enter}
Sleep 150
SendInput, {F6}/do На бронижелете висит нашивка: [ МВД | %fakeRank% | %fakeName% ].{Enter}
Return

ЛекцияМВД:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/s Уважаемые сотрудники, сейчас проведу лекцию про субординацию.{Enter}
Sleep 1000
SendInput, {F6}/s Вам запрещено пререкаться со старшим составом.{Enter}
Sleep 1000
SendInput, {F6}/s Оспаривать приказы и поручения.{Enter}
Sleep 1000
SendInput, {F6}/s Запрещено называть коллег на Ты, необходимо на Вы.{Enter}
Sleep 1000
SendInput, {F6}/s Далее... Запрещено оскорблять или передразнивать коллег.{Enter}
Sleep 1000
SendInput, {F6}/s За нарушение этих правил Вы можете получить выговор.{Enter}
Sleep 1000
SendInput, {F6}/s Лекция закончена. Спасибо за внимание.{Enter}
Return

; Функции для ФСИН

ПриветствиеФСИН:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}Здравия желаю, %fakeRank% ФСИН - %fakeName%. {Enter}
Sleep, 800
SendInput, {F6}/me отдал воинское приветствие{Enter}
Sleep 900
SendInput, {F6}/anim 1 7{Enter}
Sleep 900
SendInput, {F6}/do В нагрудном кармане удостоверение личности.{Enter}
Sleep 900
SendInput, {F6}/me протянув руку к нагрудному карману, расстегнул нагрудный карман{Enter}
Sleep 900
SendInput, {F6}/do Нагрудный карман расстегнут.{Enter}
Sleep 900
SendInput, {F6}/me достал из нагрудного кармана удостоверение личности и предъявил его гражданину{Enter}
Sleep 900
if (playerId = "null") {
    SendInput, {F6}/doc{Space}
    Input, tempId, V I M, {Enter}
} else {
    Sleep 800
    SendInput, {F6}/doc %playerId%{Enter}
}
Sleep 500
SendInput, {Down}{Enter}
Sleep 900
SendInput, {F6}/do В удостоверение личности написано: %fakeRank%{Enter}
Sleep 900
Return

ЛекцияФСИН:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/s Уважаемые сотрудники, сейчас проведу лекцию про субординацию.{Enter}
Sleep 1000
SendInput, {F6}/s Вам запрещено пререкаться со старшим составом.{Enter}
Sleep 1000
SendInput, {F6}/s Оспаривать приказы и поручения.{Enter}
Sleep 1000
SendInput, {F6}/s Запрещено называть коллег на Ты, необходимо на Вы.{Enter}
Sleep 1000
SendInput, {F6}/s Далее... Запрещено оскорблять или передразнивать коллег.{Enter}
Sleep 1000
SendInput, {F6}/s За нарушение этих правил Вы можете получить выговор.{Enter}
Sleep 1000
SendInput, {F6}/s Лекция закончена. Спасибо за внимание.{Enter}
Return

; Доп. функции

РандомЛекция:
Random, num, 1, 7
    lec := "Лекция" num
    Goto %lec%
Return

ПереключитьАхк: ; 0 - Обычный, 1 - Строй, 2 - Допрос/вербовка, 3 - Маскировка
if (scriptMode=0){
    scriptMode := 1
    StateInfo("Строй","BDCCD9")
}
else if (scriptMode=1){
    scriptMode := 2
    StateInfo("Допрос/вербовка","6D8387")
}
else if (scriptMode=2){
    scriptMode := 3
    StateInfo("Маскировка","3B4ACC")
}
else if (scriptMode=3){
    scriptMode := 0
    StateInfo("Обычный","FFFFFF")
}
Return

Ctrl & P::
    full_rp := !full_rp
    StateInfo("Фулл РП:"+full_rp,"FFFFFF")
Return
Alt & K::
    hotkeys := !hotkeys
    StateInfo("Клавиши:"+hotkeys,"FFFFFF")
Return
Alt & C::
    commands := !commands
    StateInfo("Команды:"+commands,"FFFFFF")
Return

!n::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/n Откат.{Enter}
Return

^n::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/n Намеренные действия не откатываются.{Enter}
Return

!f::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/c 60{Enter}
Return

^f::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/c 60{Enter}
Sleep 1500
SendInput,{F8}
Return

LAlt & RAlt::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/radio_set{Enter}
Return

LShift & RAlt::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/rc{Enter}
Return



; Доп. функции

GetMinuteWord(num) {
    lastDigit := Mod(num, 10)
    lastTwoDigits := Mod(num, 100)
    
    if (lastTwoDigits >= 11 && lastTwoDigits <= 19)
        return "минут"
    
    if (lastDigit = 1)
        return "минута"
    else if (lastDigit >= 2 && lastDigit <= 4)
        return "минуты"
    else
        return "минут"
}

CheckForUpdates() {
    global RAW_URL, TMP_FILE, CURRENT_VERSION, VERSION_LINE_PATTERN

    UrlDownloadToFile, %RAW_URL%, %TMP_FILE%
    if (ErrorLevel) {
        MsgBox, 48, Update Check Failed, Could not reach GitHub.`nCheck your internet connection.
        return
    }

    remoteVersion := ExtractVersion(TMP_FILE, VERSION_LINE_PATTERN)

    if (remoteVersion = "") {
        MsgBox, 48, Update Check Failed, Could not find the version string in the remote file.`nPattern: %VERSION_LINE_PATTERN%
        FileDelete, %TMP_FILE%
        return
    }

    if (VersionIsNewer(remoteVersion, CURRENT_VERSION)) {
        MsgBox, 36, Update Available, A new version is available!`n`nCurrent:  %CURRENT_VERSION%`nLatest:   %remoteVersion%`n`nDownload and install now?
        IfMsgBox, Yes
            ApplyUpdate()
        else
            FileDelete, %TMP_FILE%
    } else {
        FileDelete, %TMP_FILE%
    }
}

ApplyUpdate() {
    global TMP_FILE, USER_CONFIG_VARS

    currentScript := A_ScriptFullPath
    pid           := A_ProcessID
    batchPath     := A_Temp . "\ahk_do_update.bat"

    PreserveUserConfig(currentScript, TMP_FILE, USER_CONFIG_VARS)

    batchContent := "@echo off" . "`r`n"
        . ":wait" . "`r`n"
        . "tasklist /fi ""PID eq " . pid . """ 2>nul | find /i ""autohotkey"" >nul" . "`r`n"
        . "if not errorlevel 1 (" . "`r`n"
        . "    timeout /t 1 /nobreak >nul" . "`r`n"
        . "    goto wait" . "`r`n"
        . ")" . "`r`n"
        . "timeout /t 1 /nobreak >nul" . "`r`n"
        . "copy /y """ . TMP_FILE . """ """ . currentScript . """" . "`r`n"
        . "if errorlevel 1 (echo Update failed: could not copy file. & pause & exit /b 1)" . "`r`n"
        . "start """" """ . currentScript . """" . "`r`n"
        . "del """ . batchPath . """" . "`r`n"

    FileDelete, %batchPath%
    FileAppend, %batchContent%, %batchPath%

    Run, cmd.exe /c "%batchPath%",, Hide
    ExitApp
}

PreserveUserConfig(srcFile, dstFile, varList) {
    local i, varName, currentValue, newContent, line, patched

    savedValues := {}
    Loop, % varList.MaxIndex()
    {
        varName      := varList[A_Index]
        currentValue := ExtractVarValue(srcFile, varName)
        if (currentValue != "")
            savedValues[varName] := currentValue
    }

    newContent := ""
    Loop, Read, %dstFile%
    {
        line    := A_LoopReadLine
        patched := false

        for varName, savedVal in savedValues
        {
            if RegExMatch(line, "^(\s*" . varName . "\s*:?=\s*)[""']([^""']*)[""'](.*)", m) {
                line    := m1 . """" . savedVal . """" . m3
                patched := true
                break
            }
        }

        newContent .= line . "`r`n"
    }

    FileDelete, %dstFile%
    FileAppend, %newContent%, %dstFile%
}

ExtractVarValue(filePath, varName) {
    Loop, Read, %filePath%
    {
        if RegExMatch(A_LoopReadLine, "^\s*" . varName . "\s*:?=\s*[""']([^""']*)[""']", m)
            return m1
    }
    return ""
}

ExtractVersion(filePath, pattern) {
    local version
    Loop, Read, %filePath%
    {
        if InStr(A_LoopReadLine, pattern) {
            if RegExMatch(A_LoopReadLine, "[""']([^""']+)[""']", m)
                return m1
        }
    }
    return ""
}

VersionIsNewer(candidate, current) {
    local a, b, maxLen, av, bv
    a := StrSplit(RegExReplace(candidate, "^v", ""), ".")
    b := StrSplit(RegExReplace(current,   "^v", ""), ".")
    maxLen := Max(a.MaxIndex(), b.MaxIndex())
    Loop, %maxLen%
    {
        av := (A_Index <= a.MaxIndex()) ? a[A_Index] + 0 : 0
        bv := (A_Index <= b.MaxIndex()) ? b[A_Index] + 0 : 0
        if (av > bv)
            return true
        if (av < bv)
            return false
    }
    return false
}

Max(a, b) {
    return (a > b) ? a : b
}

ConvertToUTF8(ByRef SafeArray) {
    size := SafeArray.MaxIndex() + 1
    VarSetCapacity(data, size)
    
    DllCall("oleaut32\SafeArrayAccessData", "Ptr", ComObjValue(SafeArray), "Ptr*", pData)
    DllCall("RtlMoveMemory", "Ptr", &data, "Ptr", pData, "Ptr", size)
    DllCall("oleaut32\SafeArrayUnaccessData", "Ptr", ComObjValue(SafeArray))
    
    return StrGet(&data, "UTF-8")
}

Parser(SheetID, TabID) {
    URL := "https://docs.google.com/spreadsheets/d/" . SheetID . "/export?format=csv&gid=" . TabID

    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", URL, true)
    whr.Send()
    whr.WaitForResponse()

    RawData := ConvertToUTF8(whr.ResponseBody)

    DataDict := []
    Loop, Parse, RawData, `n, `r 
    {
        if (A_Index = 1 || Trim(A_LoopField) = "")
            Continue

        CurrentID := ""
        CurrentReason := ""
        
        Loop, Parse, A_LoopField, CSV 
        {
            if (A_Index = 1)
                CurrentID := Trim(A_LoopField)
            if (A_Index = 2)
                CurrentReason := Trim(A_LoopField)
        }

        DataDict.Push({id: CurrentID, reason: CurrentReason})
    }
    
    return DataDict
}

WM_CTLCOLOREDIT(wParam, lParam) {
    global hEdit
    static Brush := 0
    
    if (lParam = hEdit) {
        DllCall("SetBkColor", "UInt", wParam, "UInt", 0x202020)
        DllCall("SetTextColor", "UInt", wParam, "UInt", 0xFFFFFF)
        if (!Brush)
            Brush := DllCall("CreateSolidBrush", "UInt", 0x202020)
        return Brush
    }
}

GetMonitorInfo() {
    SysGet, MonitorWorkArea, MonitorWorkArea
    screenWidth := MonitorWorkAreaRight - MonitorWorkAreaLeft
    screenHeight := MonitorWorkAreaBottom - MonitorWorkAreaTop
    
    ; Определяем тип экрана
    if (screenWidth <= 1366)
        screenType := "Ноутбук (15.6\)"
    else if (screenWidth <= 1920)
        screenType := "Монитор (23.8\)"
    else
        screenType := "Большой монитор (27\)"
    
    result := "Размер экрана: " . screenWidth . "x" . screenHeight . "`n"
    result .= "Тип: " . screenType . "`n"
    result .= "Рекомендуемый размер шрифта: " . (screenWidth <= 1366 ? 18 : screenWidth <= 1920 ? 25 : 32)
    
    return result
}

; Интерфейсы с подсказками

SavedInfo(playerId, fakeName) {
    Gui 3:+LastFound +AlwaysOnTop -Caption +ToolWindow 

    SysGet, MonitorWorkArea, MonitorWorkArea

    Gui, 3:Color, 000000
    Gui, 3:Font, MS sans serif
    Gui, 3:Font, cBlue
    Gui, 3:Font, s8
    Gui, 3:Add, Text, cWhite, Сохранено ID: %playerId%
    Gui, 3:Add, Text, cWhite, Маскировочное имя: %fakeName%
    WinSet, TransColor, %CustomColor3% 250 

    Gui, 3:Show, Hide
    WinGetPos,,, width, height
    yPos := MonitorWorkAreaBottom - height
    xPos := MonitorWorkAreaRight - width - 10
    
    Gui, 3:Show, x%xPos% y%yPos% NoActivate, window.
}

StateInfo(text, textColor:="White") {
    Gui 1:+LastFound +AlwaysOnTop -Caption +ToolWindow 

    SysGet, MonitorWorkArea, MonitorWorkArea

    Gui, 1:Color, 000000
    Gui, 1:Font, MS sans serif
    Gui, 1:Font, cBlue
    Gui, 1:Font, s25
    Gui, 1:Add, Text, c%textColor%, %text%
    WinSet, TransColor, %CustomColor3% 250 

    Gui, 1:Show, Hide
    WinGetPos,,, width, height
    yPos := MonitorWorkAreaBottom - height - 20
    xPos := MonitorWorkAreaRight - width - 20
    
    Gui, 1:Show, x%xPos% y%yPos% NoActivate, window.
    Sleep 2000
    Gui, 1:Destroy
}

KeyInfo(title, lines*) {
    global infoState
    if (infoState)
        Return

    CustomColor3 := "202020"
    Gui, 2:+LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui, 2:Color, %CustomColor3%
    WinSet, Transparent, 150

    SysGet, MonitorWorkArea, MonitorWorkArea
    MonitorWorkAreaRight -= 5

    Gui, 2:Font, cWhite w25, MS Sans Serif

    Gui, 2:Add, Text, cWhite,
    Gui, 2:Add, Text, cWhite, %title%
    Gui, 2:Add, Text, cWhite,
    for _, line in lines
        Gui, 2:Add, Text, cWhite, %line%
    Gui, 2:Add, Text, cWhite,

    Gui, 2:Show, Hide
    WinGetPos,,, width, height
    yPos := (MonitorWorkAreaBottom - MonitorWorkAreaTop - height) // 2 + MonitorWorkAreaTop
    xPos := MonitorWorkAreaRight - width
    Gui, 2:Show, x%xPos% y%yPos% NoActivate, window.

    infoState := true
}


ExtendedInfo(title, lines*) {
    global infoState, hEdit
    if (infoState)
        Return

    SysGet, MonitorWorkArea, MonitorWorkArea
    screenWidth := MonitorWorkAreaRight - MonitorWorkAreaLeft
    screenHeight := MonitorWorkAreaBottom - MonitorWorkAreaTop
    

    windowWidthPercent := 90
    windowHeightPercent := 80
    
    marginTop := 15
    marginBottom := 15
    marginLeft := 15
    marginRight := 15
    
    maxWindowWidth := Round(screenWidth * windowWidthPercent / 100)
    maxWindowHeight := Round(screenHeight * windowHeightPercent / 100)
    
    content := "`r`n" . title . "`r`n`r`n"
    for _, line in lines
        content .= line . "`r`n"
    content .= "`r`n"
    
    if (screenWidth <= 1366) {
        fontSize := 7
        lineHeight := 24
        charWidth := 10
    } else if (screenWidth <= 1920) {
        fontSize := 10
        lineHeight := 34
        charWidth := 14
    } else {
        fontSize := 16
        lineHeight := 42
        charWidth := 18
    }
    
    CustomColor3 := "202020"
    Gui, 2:+LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui, 2:Color, %CustomColor3%
    WinSet, Transparent, 150
    Gui, 2:Font, cWhite s%fontSize% w400, MS Sans Serif
    
    numLines := 0
    Loop, Parse, content, `r`n
        numLines++
    
    maxLineWidth := 0
    Loop, Parse, content, `r`n
    {
        if (A_LoopField = "")
            continue
        thisWidth := StrLen(A_LoopField) * charWidth + 50
        if (thisWidth > maxLineWidth)
            maxLineWidth := thisWidth
    }
    
    editPaddingX := 20
    editPaddingY := 20
    
    requiredWidth := maxLineWidth + editPaddingX + 20
    requiredHeight := (numLines * lineHeight) + editPaddingY
    
    finalW := (requiredWidth < maxWindowWidth) ? requiredWidth : maxWindowWidth
    finalH := (requiredHeight < maxWindowHeight) ? requiredHeight : maxWindowHeight
    
    minWidth := 300
    minHeight := 200
    finalW := (finalW < minWidth) ? minWidth : finalW
    finalH := (finalH < minHeight) ? minHeight : finalH
    
    Gui, 2:Add, Edit, w%finalW% h%finalH% +Multi +ReadOnly +VScroll -Wrap -E0x200 -Border hwndhEdit cWhite, %content%
    
    Gui, 2:Show, Hide

    xPos := marginLeft
    yPos := marginTop
    
    PostMessage, 0xB5, 0, 0,, ahk_id %hEdit% 
    PostMessage, 0xB1, 0, -1,, ahk_id %hEdit%
    PostMessage, 0xB6, 0, 0,, ahk_id %hEdit% 
    
    Sleep, 50
    
    Gui, 2:Show, x%xPos% y%yPos% NoActivate, window.
    
    infoState := true
    OnMessage(0x133, "WM_CTLCOLOREDIT")
}

DestroyInfo:
Gui, 2:Destroy
infoState := false
Return



; Горячие клавиши для показа информации 24MP59G


#If (keyModifier = "")
F9 & Numpad0::
    KeyInfo("Что делает Numpad0:"
        , "Режим: Обычный"
        , "| N0: Ввод id игрока для дальнейших действий"
        , "| N0 + LAlt: Очистить последнее введенное id (если хотите вводить вручную)"
        , "| N0 + Ctrl: Ввести ник маскировки (для использования ахк других орг.)"
        , "| N0 + RAlt: Очистить маскировочный ник"
        , "Режим: Строй"
        , "| N0: Сбор строя"
        , "| N0 + LAlt: Информация о строе"
        , "Режим: Допрос/вербовка"
        , "| N0: Миранда для допроса"
        , "| N0 + Ctrl: Принять в ФСБ"
        , "Режим: Маскировка"
        , "| N0: Приветсвие МО"
        , "| N0 + LAlt: Лекция МО")
Return

F9 & Numpad1::
    KeyInfo("Что делает Numpad1:"
        , "Режим: Обычный"
        , "| N1: Представится и показать нашивку ФСБ"
        , "| N1 + LAlt: Показать удостоверение ФСБ"
        , "| N1 + Ctrl: Показать только нашивку"
        , "Режим: Строй"
        , "| N1: Лекция"
        , "Режим: Допрос/вербовка"
        , "| N1: Начало допроса"
        , "| N1 + LAlt: Конец вербовки (5+ ранг)"
        , "| N1 + Ctrl: Повысить"
        , "Режим: Маскировка"
        , "| N1: Приветсвие МВД"
        , "| N1 + LAlt: Лекция МВД")
Return

F9 & Numpad2::
    KeyInfo("Что делает Numpad2:"
        , "Режим: Обычный"
        , "| N2: Попросить остановится гражданина"
        , "| N2 + LAlt: Оповестить о работе ФСБ"
        , "| N2 + Shift: Оповестить о работе ФСБ в мегафон"
        , "| N2 + Ctrl: Попросить документы у гражданина"
        , "| N2 + RAlt: Взять документы"
        , "Режим: Строй"
        , "| N2: Тренировка"
        , "Режим: Допрос/вербовка"
        , "| N2: Продолжение допроса"
        , "| N2 + Ctrl: Занести в ЧС"
        , "Режим: Маскировка"
        , "| N2: Приветсвие ФСИН"
        , "| N2 + LAlt: Лекция ФСИН")
Return

F9 & Numpad3::
    KeyInfo("Что делает Numpad3:"
        , "Режим: Обычный"
        , "| N3: Отследить местопложение игрока"
        , "| N3 + LAlt: Начать погоню за нарушителем"
        , "| N3 + Ctrl: Надеть наручники + сопровождение"
        , "| N3 + RAlt: снять наручники + сопровождение"
        , "Режим: Допрос/вербовка"
        , "| N3: Конец допроса"
        , "Режим: Маскировка"
        , "| N3: Начать прослушку")
Return

F9 & Numpad4::
    KeyInfo("Что делает Numpad4:"
        , "Режим: Обычный"
        , "| N4: Обыскать человека на котиков"
        , "| N4 + LAlt: Забрать запрещенку"
        , "| N4 + Ctrl: Найти документы в карманах человека"
        , "| N4 + RAlt: Обыск багажника"
        , "Режим: Допрос/вербовка"
        , "| N4: Начало вербовки (Попросить удо)"
        , "| N4 + LAlt: Проверить документы у вербовуемого")
Return

F9 & Numpad5::
    KeyInfo("Что делает Numpad5:"
        , "Режим: Обычный"
        , "| N5: Снять маску и другие аксессуары"
        , "| N5 + LAlt: Опознать человека по лицу"
        , "| N5 + Ctrl: Опознать человека по отпечаткам"
        , "| N5 + RAlt: Найти владельца авто по НЗ"
        , "Режим: Допрос/вербовка"
        , "| N5: Попросить паспорт")
Return

F9 & Numpad6::
    KeyInfo("Что делает Numpad6:"
        , "Режим: Обычный"
        , "| N6: Выдать розыск"
        , "| N6 + LAlt: Выписать штраф"
        , "| N6 + Ctrl: Забрать лицензию"
        , "| N6 + RAlt: Снять розыск"
        , "Режим: Допрос/вербовка"
        , "| N6: Попросить мед. карту")
Return

F9 & Numpad7::
    KeyInfo("Что делает Numpad7:"
        , "Режим: Обычный"
        , "| N7: Выкинуть из автомобиля"
        , "| N7 + LAlt: Посадить в автомобиль"
        , "| N7 + Ctrl: Выломать дверь в дом"
        , "| N7 + RAlt: Список розыска"
        , "Режим: Допрос/вербовка"
        , "| N7: Попросить лицензии")
Return

F9 & Numpad8::
    KeyInfo("Что делает Numpad8:"
        , "Режим: Обычный"
        , "| N8: Зачитать права"
        , "| N8 + LAlt: Вызвать адвоката"
        , "| N8 + Ctrl: Адвокат не приедет"
        , "| N8 + RAlt: Полицейский планшет"
        , "Режим: Допрос/вербовка"
        , "| N8: Попросить /team_history"
        , "| N8 + LAlt: Вербовка хорошо"
        , "| N8 + Ctrl: Вербовка отказ")
Return

F9 & Numpad9::
    KeyInfo("Что делает Numpad9:"
        , "Режим: Обычный"
        , "| N9: Поставить барикаду"
        , "| N9 + LAlt: Убрать барикаду"
        , "| N9 + Ctrl: Выдать выговор"
        , "| N9 + RAlt: Уволить из организации"
        , "Режим: Допрос/вербовка"
        , "| N9: Забрать звукозапис. устройство"
        , "| N9 + LAlt: Полная секретность в авто")
Return
#If

#If (keyModifier != "")
F9 & 1::
    KeyInfo("Что делает 1:"
        , "Режим: Обычный"
        , "| 1: Ввод id игрока для дальнейших действий"
        , "| 1 + LAlt: Очистить последнее введенное id (если хотите вводить вручную)"
        , "| 1 + Ctrl: Ввести ник маскировки (для использования ахк других орг.)"
        , "| 1 + RAlt: Очистить маскировочный ник"
        , "Режим: Строй"
        , "| 1: Сбор строя"
        , "| 1 + LAlt: Информация о строе"
        , "Режим: Допрос/вербовка"
        , "| 1: Миранда для допроса"
        , "| 1 + Ctrl: Принять в ФСБ"
        , "Режим: Маскировка"
        , "| 1: Приветсвие МО"
        , "| 1 + LAlt: Лекция МО")
Return

F9 & 2::
    KeyInfo("Что делает 2:"
        , "Режим: Обычный"
        , "| 2: Представится и показать нашивку ФСБ"
        , "| 2 + LAlt: Показать удостоверение ФСБ"
        , "| 2 + Ctrl: Показать только нашивку"
        , "Режим: Строй"
        , "| 2: Лекция"
        , "Режим: Допрос/вербовка"
        , "| 2: Начало допроса"
        , "| 2 + LAlt: Конец вербовки (5+ ранг)"
        , "| 2 + Ctrl: Повысить"
        , "Режим: Маскировка"
        , "| 2: Приветсвие МВД"
        , "| 2 + LAlt: Лекция МВД")
Return

F9 & 3::
    KeyInfo("Что делает 3:"
        , "Режим: Обычный"
        , "| 3: Попросить остановится гражданина"
        , "| 3 + LAlt: Оповестить о работе ФСБ"
        , "| 3 + Shift: Оповестить о работе ФСБ в мегафон"
        , "| 3 + Ctrl: Попросить документы у гражданина"
        , "| 3 + RAlt: Взять документы"
        , "Режим: Строй"
        , "| 3: Тренировка"
        , "Режим: Допрос/вербовка"
        , "| 3: Продолжение допроса"
        , "| 3 + Ctrl: Занести в ЧС"
        , "Режим: Маскировка"
        , "| 3: Приветсвие ФСИН"
        , "| 3 + LAlt: Лекция ФСИН")
Return

F9 & 4::
    KeyInfo("Что делает 4:"
        , "Режим: Обычный"
        , "| 4: Отследить местопложение игрока"
        , "| 4 + LAlt: Начать погоню за нарушителем"
        , "| 4 + Ctrl: Надеть наручники + сопровождение"
        , "| | 4 + RAlt: снять наручники + сопровождение"
        , "Режим: Допрос/вербовка"
        , "| 4: Конец допроса"
        , "Режим: Маскировка"
        , "| 4: Начать прослушку")
Return

F9 & 5::
    KeyInfo("Что делает 5:"
        , "Режим: Обычный"
        , "| 5: Обыскать человека на котиков"
        , "| 5 + LAlt: Забрать запрещенку"
        , "| 5 + Ctrl: Найти документы в карманах человека"
        , "| 5 + RAlt: Обыск багажника"
        , "Режим: Допрос/вербовка"
        , "| 5: Начало вербовки (Попросить удо)"
        , "| 5 + LAlt: Проверить документы у вербовуемого")
Return

F9 & 6::
    KeyInfo("Что делает 6:"
        , "Режим: Обычный"
        , "| 6: Снять маску и другие аксессуары"
        , "| 6 + LAlt: Опознать человека по лицу"
        , "| 6 + Ctrl: Опознать человека по отпечаткам"
        , "| 6 + RAlt: Найти владельца авто по НЗ"
        , "Режим: Допрос/вербовка"
        , "| 6: Попросить паспорт")
Return

F9 & 7::
    KeyInfo("Что делает 7:"
        , "Режим: Обычный"
        , "| 7: Выдать розыск"
        , "| 7 + LAlt: Выписать штраф"
        , "| 7 + Ctrl: Забрать лицензию"
        , "| 7 + RAlt: Снять розыск"
        , "Режим: Допрос/вербовка"
        , "| 7: Попросить мед. карту")
Return

F9 & 8::
    KeyInfo("Что делает 8:"
        , "Режим: Обычный"
        , "| 8: Выкинуть из автомобиля"
        , "| 8 + LAlt: Посадить в автомобиль"
        , "| 8 + Ctrl: Выломать дверь в дом"
        , "| 8 + RAlt: Список розыска"
        , "Режим: Допрос/вербовка"
        , "| 8: Попросить лицензии")
Return

F9 & 9::
    KeyInfo("Что делает 9:"
        , "Режим: Обычный"
        , "| 9: Зачитать права"
        , "| 9 + LAlt: Вызвать адвоката"
        , "| 9 + Ctrl: Адвокат не приедет"
        , "| 9 + RAlt: Полицейский планшет"
        , "Режим: Допрос/вербовка"
        , "| 9: Попросить /team_history"
        , "| 9 + LAlt: Вербовка хорошо"
        , "| 9 + Ctrl: Вербовка отказ")
Return

F9 & 0::
    KeyInfo("Что делает 0:"
        , "Режим: Обычный"
        , "| 0: Поставить барикаду"
        , "| 0 + LAlt: Убрать барикаду"
        , "| 0 + Ctrl: Выдать выговор"
        , "| 0 + RAlt: Уволить из организации"
        , "Режим: Допрос/вербовка"
        , "| 0: Забрать звукозапис. устройство"
        , "| 0 + LAlt: Полная секретность в авто")
Return
#If

F5 & 1::
    ExtendedInfo("Уголовный Кодекс", UKLines*)
Return

F5 & 2::
    ExtendedInfo("Кодекс об административных правонарушениях", KOAPLines*)
Return

F5 & 3::
    ExtendedInfo("Процессуальный кодекс", PROCLines*)
Return

F5 & 4::
    ExtendedInfo("Устав МО", MOLines*)
Return

F5 & 5::
    ExtendedInfo("ФЗоП", MVDLines*)
Return

F5 & 6::
    ExtendedInfo("Устав СОБР", SOBRLines*)
Return

F5 & 7::
    ExtendedInfo("Устав ФСИН", FSINLines*)
Return

F5 & 8::
    ExtendedInfo("Устав ФАКЕЛ", FAKELLines*)
Return

F5 & 9::
    ExtendedInfo("Устав ФСБ", FSBLines*)
Return

F5 & 1 up::
F5 & 2 up::
F5 & 3 up::
F5 & 4 up::
F5 & 5 up::
F5 & 6 up::
F5 & 7 up::
F5 & 8 up::
F5 & 9 up::
F9 & 0 up::
F9 & 1 up::
F9 & 2 up::
F9 & 3 up::
F9 & 4 up::
F9 & 5 up::
F9 & 6 up::
F9 & 7 up::
F9 & 8 up::
F9 & 9 up::
F9 & Numpad0 up::
F9 & Numpad1 up::
F9 & Numpad2 up::
F9 & Numpad3 up::
F9 & Numpad4 up::
F9 & Numpad5 up::
F9 & Numpad6 up::
F9 & Numpad7 up::
F9 & Numpad8 up::
F9 & Numpad9 up::goto DestroyInfo
