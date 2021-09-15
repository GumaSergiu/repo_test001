
Procedure PressExecuteButton(Button)
	
//	 // <<>>Guma   13.09.2021

Если RaportAmanunt        Тогда
Выборка=Документы.RaportDeVanzariCuAmanunt.Выбрать(BegOfDay(DataInc),EndOfDay(DataSf));
Пока Выборка.Следующий() Цикл

Если Выборка.Проведен=Истина Тогда
Набор = РегистрыНакопления.Vanzari.СоздатьНаборЗаписей();
Набор.Отбор.Регистратор.Установить(Выборка.Ссылка);
Набор.Прочитать();
Для Каждого ТекущаяСтрока Из Выборка.Marfuri Цикл
	н=0;
	Для Каждого Движение Из Набор Цикл
		Если Движение.Nomenclator = ТекущаяСтрока.Nomenclator  Тогда
		н=н+1;
		 Движение.ContVenituri =  ТекущаяСтрока.ContVenituri ;
		 Движение.PozitieInDocument= н;
		 Набор.Записать(Истина);
		  КонецЕсли;
		КонецЦикла;
	
КонецЦикла;
Для Каждого ТекущаяСтрока Из Выборка.Servicii Цикл
	а=  0;
	Для Каждого Движение Из Набор Цикл
		Если Движение.Nomenclator = ТекущаяСтрока.Nomenclator Тогда
		 а=а+1;
		 Движение.ContVenituri =  ТекущаяСтрока.ContVenituri ;
		 Движение.PozitieInDocument=а;

		 Набор.Записать(Истина);
		  КонецЕсли;
		КонецЦикла;
	
КонецЦикла;

КонецЕсли;
 Сообщить("Executat doc"+Выборка.Ссылка);
КонецЦикла;
КонецЕсли;
///////////////////
Если Factura	Тогда

Выборка=Документы.VanzareMarfuriSiServiciiPrestate.Выбрать(BegOfDay(DataInc),EndOfDay(DataSf));
Пока Выборка.Следующий() Цикл

Если Выборка.Проведен=Истина Тогда
Набор = РегистрыНакопления.Vanzari.СоздатьНаборЗаписей();
Набор.Отбор.Регистратор.Установить(Выборка.Ссылка);
Набор.Прочитать();
Для Каждого ТекущаяСтрока Из Выборка.Marfuri Цикл
	н=0;
	Для Каждого Движение Из Набор Цикл
		Если Движение.Nomenclator = ТекущаяСтрока.Nomenclator Тогда
		н=н+1;
		Движение.ContVenituri =  ТекущаяСтрока.ContVenituri ;
		Движение.PozitieInDocument=н;
 
		 Набор.Записать(Истина);
		  КонецЕсли;
		КонецЦикла;
	
КонецЦикла;
Для Каждого ТекущаяСтрока Из Выборка.Servicii Цикл
	а=0;
	Для Каждого Движение Из Набор Цикл
		Если Движение.Nomenclator = ТекущаяСтрока.Nomenclator Тогда
		а=а+1;
		 Движение.ContVenituri =  ТекущаяСтрока.ContVenituri ;
		 Движение.PozitieInDocument=а;
		 Набор.Записать(Истина);
		  КонецЕсли;
	КонецЦикла;
	
КонецЦикла;
 If Выборка.Imobilizari.Count() > 0 Then   //Guma S.  03/06/2015
	 Набор1 = РегистрыНакопления.Vanzari.СоздатьНаборЗаписей();
	 Набор1.Отбор.Регистратор.Установить(Выборка.Ссылка);
	 For Each CurRowImobilizari In Выборка.Imobilizari Do
		CotaPRTVAs=Module_TVA.GetCotaTVA(CurRowImobilizari.CotaTVA);
		Movement = Набор1.Добавить();
		Movement.Period 	 = Выборка.Date;
		Movement.Nomenclator = CurRowImobilizari.Nomenclator;
		Movement.Contract 	 = Выборка.Contract;
		Movement.Document 	 = Выборка.Ref;
		Movement.Departament = Выборка.Departament;
		Movement.Depozit 	 = Выборка.Depozit;
		Movement.ManagerDeVanzari = Выборка.ManagerDeVanzari;
        Movement.ProcentDiscount 	 = 0;
        Movement.ValoareFaraDiscount= 0;
	    Movement.Count 		 = CurRowImobilizari.Count;
        Movement.Valoare = (CurRowImobilizari.Suma-CurRowImobilizari.SumaTVA) + ( -?(Module_TVA.TaxareInversa(CurRowImobilizari.CotaTVA), CurRowImobilizari.SumaTVA, 0)+ ?(Module_TVA.TaxareInversa(CurRowImobilizari.CotaTVA), 0, CurRowImobilizari.SumaTVA));
		Movement.ValoareaFaraTVA = CurRowImobilizari.Suma-(CurRowImobilizari.Suma*CotaPRTVAs/(100+CotaPRTVAs)) ; 		
		Movement.ContVenituri =  CurRowImobilizari.ContVenituri ;
        Movement.PozitieInDocument =  CurRowImobilizari.LineNumber ;
		Набор1.Записать(Истина);
     	
		EndDo;

 EndIf;   //Guma S.  03/06/2015

КонецЕсли;
 Сообщить("Executat doc"+Выборка.Ссылка);
КонецЦикла;
КонецЕсли;
///////////////////////////////////////
Если Retur	Тогда

Выборка=Документы.ReturDeLaClient.Выбрать(BegOfDay(DataInc),EndOfDay(DataSf));
Пока Выборка.Следующий() Цикл

Если Выборка.Проведен=Истина Тогда
Набор = РегистрыНакопления.Vanzari.СоздатьНаборЗаписей();
Набор.Отбор.Регистратор.Установить(Выборка.Ссылка);
Набор.Прочитать();
Для Каждого ТекущаяСтрока Из Выборка.Marfuri Цикл
	н=0;
	Для Каждого Движение Из Набор Цикл
		Если Движение.Nomenclator = ТекущаяСтрока.Nomenclator Тогда
		н=н+1;
		Движение.ContVenituri =  ТекущаяСтрока.ContVenituri ;
		Движение.PozitieInDocument=н;
        Движение.Document= Выборка.Ссылка;

		 Набор.Записать(Истина);
		  КонецЕсли;
		КонецЦикла;
	
КонецЦикла;
Для Каждого ТекущаяСтрока Из Выборка.Servicii Цикл
	а=0;
	Для Каждого Движение Из Набор Цикл
		Если Движение.Nomenclator = ТекущаяСтрока.Nomenclator Тогда
		а=а+1;
		 Движение.ContVenituri =  ТекущаяСтрока.ContVenituri ;
		 Движение.PozitieInDocument=а;
		 Набор.Записать(Истина);
		  КонецЕсли;
		КонецЦикла;
	
КонецЦикла;

КонецЕсли;
 Сообщить("Executat doc"+Выборка.Ссылка);
КонецЦикла;
КонецЕсли;

EndProcedure
