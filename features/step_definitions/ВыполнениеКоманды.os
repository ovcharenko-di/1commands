﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd
#Использовать "../.."

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯДобавляюПараметрыДляКоманды");
	ВсеШаги.Добавить("ЯВыполняюКомандуЧерезКомандныйПроцессорСистемы");
	ВсеШаги.Добавить("ЯВыполняюКомандуБезКомандногоПроцессораСистемы");
	ВсеШаги.Добавить("ЯУстанавливаюОжидаемыйКодВозвратаДляКоманды");
	ВсеШаги.Добавить("ЯПолучаюИсключениеПриВыполненииКоманды");
	ВсеШаги.Добавить("ЯУстанавливаюОжидаемыйДиапазонКодовВозвратаОтДоДляКоманды");
	ВсеШаги.Добавить("ЯУстанавливаюПериодОпросаЗавершенияКомандыВМиллисекунду");
	ВсеШаги.Добавить("ЯСнимаюФлагПоказаНемедленногоВыводаКоманды");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// TODO перенести методы (2 шт) в 1bdd для исключения дублирования

//Я выполняю команду "oscript" через командный процессор системы
Процедура ЯВыполняюКомандуЧерезКомандныйПроцессорСистемы(Знач ИмяИлиТекстКоманды) Экспорт
	ВыполнитьКоманду(ИмяИлиТекстКоманды, Истина);
КонецПроцедуры

//Я выполняю команду "oscript" без командного процессора системы
Процедура ЯВыполняюКомандуБезКомандногоПроцессораСистемы(Знач ИмяИлиТекстКоманды) Экспорт
	ВыполнитьКоманду(ИмяИлиТекстКоманды, Ложь);
КонецПроцедуры

//Я устанавливаю ожидаемый код возврата 0 для команды "oscript"
Процедура ЯУстанавливаюОжидаемыйКодВозвратаДляКоманды(Знач ОжидаемыйКодВозврата, Знач ИмяИлиТекстКоманды) Экспорт
	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);
	
	Команда.УстановитьПравильныйКодВозврата(ОжидаемыйКодВозврата);
КонецПроцедуры

//Я устанавливаю ожидаемый диапазон кодов возврата от 0 до 10 для команды "oscript"
Процедура ЯУстанавливаюОжидаемыйДиапазонКодовВозвратаОтДоДляКоманды(Знач МинимальныйОжидаемыйКодВозврата, 
		Знач МаксимальныйОжидаемыйКодВозврата, Знач ИмяИлиТекстКоманды) Экспорт

	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);
	
	Команда.УстановитьДиапазонПравильныхКодовВозврата(
		МинимальныйОжидаемыйКодВозврата, 
		МаксимальныйОжидаемыйКодВозврата);
КонецПроцедуры

//Я получаю исключение при выполнении команды "oscript"
Процедура ЯПолучаюИсключениеПриВыполненииКоманды(Знач ИмяИлиТекстКоманды) Экспорт
	Попытка
		ВыполнитьКоманду(ИмяИлиТекстКоманды, Истина);		
	Исключение
		Возврат;
	КонецПопытки;

	ВызватьИсключение СтрШаблон("Не получили исключение при выполнении команды", ИмяИлиТекстКоманды);
КонецПроцедуры

//Я устанавливаю период опроса завершения команды "oscript" в 1 миллисекунду
Процедура ЯУстанавливаюПериодОпросаЗавершенияКомандыВМиллисекунду(Знач ИмяИлиТекстКоманды, Знач ТаймаутВМиллисекундах) Экспорт

	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);
	
	Команда.УстановитьПериодОпросаЗавершения(ТаймаутВМиллисекундах);
КонецПроцедуры

//Я снимаю флаг показа немедленного вывода команды "oscript"
Процедура ЯСнимаюФлагПоказаНемедленногоВыводаКоманды(Знач ИмяИлиТекстКоманды) Экспорт
	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);

	Команда.ПоказыватьВыводНемедленно(Ложь);
КонецПроцедуры

//Я добавляю параметры для команды "oscript"
//| -version |
//| -encoding=utf-8 |
Процедура ЯДобавляюПараметрыДляКоманды(Знач ИмяИлиТекстКоманды, Знач ТаблицаПараметров) Экспорт
	//TODO перенести шаг в библиотеку 1bdd
	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);

	// ПараметрКоманды = ЗаменитьШаблоныВПараметрахКоманды(ПараметрКоманды);//TODO раскомментировать код внутри 1bdd
	МассивПараметров = ТаблицаПараметров.ВыгрузитьКолонку(0);
	Команда.ДобавитьПараметры(МассивПараметров);
КонецПроцедуры

// { Служебные функции

Процедура ВыполнитьКоманду(Знач ИмяИлиТекстКоманды, Знач ИспользуемКомандныйПроцессор = Истина)
	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);
	Команда.УстановитьИсполнениеЧерезКомандыСистемы(ИспользуемКомандныйПроцессор);
	
	Команда.Исполнить();
КонецПроцедуры

//TODO дубль кода с 1bdd::ВыполнениеКоманд.os
Функция ПолучитьКомандуИзКонтекста(Знач ИмяКоманды)

	КлючКонтекста = КлючКоманды(ИмяКоманды);
	Команда = БДД.ПолучитьИзКонтекста(КлючКонтекста);

	Если Не ЗначениеЗаполнено(Команда) Тогда
		Команда = Новый Команда;
		Команда.УстановитьКоманду(ИмяКоманды);
		БДД.СохранитьВКонтекст(КлючКонтекста, Команда);
	КонецЕсли;
	
	Возврат Команда;
КонецФункции

Функция КлючКоманды(Знач ИмяКоманды)
	Возврат "Команда-" + ИмяКоманды;
КонецФункции

//}
