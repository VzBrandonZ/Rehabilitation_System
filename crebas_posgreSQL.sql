/*==============================================================*/
/* DBMS name:      PostgreSQL 13                                */
/* Created on:     15/12/2020 16:49:30                          */
/*==============================================================*/


/*==============================================================*/
/* Table: CASO                                                  */
/*==============================================================*/
create table CASO (
   IDENTIFICACION_CASO_ID SERIAL               not null,
   IDENTIFICACION_CASO_NOMBRE CHAR(50)         not null,
   constraint PK_CASO primary key (IDENTIFICACION_CASO_ID)
);

/*==============================================================*/
/* Table: CITA                                                  */
/*==============================================================*/
create table CITA (
   CITA_ID              SERIAL               not null,
   TRABAJADOR_ID        INT                  not null,
   PACIENTE_ID          INT                  not null,
   TIPO_CITA_ID         INT                  not null,
   CITA_DESCRIPCION     CHAR(100)            not null,
   CITA_FECHA           DATE                 not null,
   CITA_HORA            TIME                 not null,
   CITA_HORA_FINAL		TIME				 not null,
   CITA_OFICINA			VARCHAR(5)			 not null,
   constraint PK_CITA primary key (CITA_ID)
);

/*==============================================================*/
/* Table: CITA_CASO                                             */
/*==============================================================*/
create table CITA_CASO (
   CITA_ID              INT                 not null,
   IDENTIFICACION_CASO_ID INT               not null,
   constraint PK_CITA_CASO primary key (CITA_ID, IDENTIFICACION_CASO_ID)
);

/*==============================================================*/
/* Table: ENTREGA                                               */
/*==============================================================*/
create table ENTREGA (
   ENTREGA_ID           SERIAL               not null,
   TRABAJADOR_ID        INT                  not null,
   PACIENTE_ID          INT                  not null,
   ENTREGA_FECHA        DATE                 not null,
   ENTREGA_HORA         TIME                 not null,
   constraint PK_ENTREGA primary key (ENTREGA_ID)
);

/*==============================================================*/
/* Table: MEDICAMENTO_CITA                                      */
/*==============================================================*/
create table MEDICAMENTO_CITA (
   CITA_ID              INT                 not null,
   MEDICAMENTO_ID       INT                 not null
);

/*==============================================================*/
/* Table: MEDICAMENTO                                           */
/*==============================================================*/
create table MEDICAMENTO (
   MEDICAMENTO_ID       SERIAL               not null,
   MEDICAMENTO_CODIGO   CHAR(5)              not null,
   MEDICAMENTO_NOMBRE   CHAR(50)             not null,
   MEDICAMENTO_TIPO     CHAR(50)             not null,
   MEDICAMENTO_CANTIDAD INT                  not null,
   constraint PK_MEDICAMENTO primary key (MEDICAMENTO_ID)
);

/*==============================================================*/
/* Table: MEDICAMENTO_ENTREGA                                   */
/*==============================================================*/
create table MEDICAMENTO_ENTREGA (
   MEDICAMENTO_ID       INT                  not null,
   ENTREGA_ID           INT                  not null,
   constraint PK_MEDICAMENTO_ENTREGA primary key (MEDICAMENTO_ID, ENTREGA_ID)
);

/*==============================================================*/
/* Table: PACIENTE                                              */
/*==============================================================*/
create table PACIENTE (
   PACIENTE_ID          SERIAL               not null,
   PACIENTE_CEDULA      CHAR(10)             not null,
   PACIENTE_NOMBRE      CHAR(30)             not null,
   PACIENTE_APELLIDO    CHAR(30)             not null,
   PACIENTE_GENERO      CHAR(30)             not null,
   PACIENTE_DIRECCION   CHAR(50)             not null,
   PACIENTE_TELEFONO    DECIMAL(10)          not null,
   PACIENTE_CORREO      CHAR(30)             null,
   PACIENTE_FECHANACIMIENTO DATE             not null,
   PACIENTE_FECHA_INGRESO DATE               not null,
   PACIENTE_REINGRESO   NUMERIC              null,
   PACIENTE_ESTADO      CHAR(20)             not null,
   PACIENTE_TIPO_ADICCION CHAR(20)           not null,
   PACIENTE_HABITACION  CHAR(20)             not null,
   PACIENTE_ALERGIA     CHAR(60)             null,
   constraint PK_PACIENTE primary key (PACIENTE_ID)
);

/*==============================================================*/
/* Table: TIPO_CITA                                             */
/*==============================================================*/
create table TIPO_CITA (
   TIPO_CITA_ID         SERIAL               not null,
   TIPO_CITA_NOMBRE     CHAR(50)             not null,
   constraint PK_TIPO_CITA primary key (TIPO_CITA_ID)
);

/*==============================================================*/
/* Table: TIPO_TRABAJADOR                                       */
/*==============================================================*/
create table TIPO_TRABAJADOR (
   TIPO_TRABAJADOR_ID   SERIAL               not null,
   TIPO_TRABAJADOR_NOMBRE CHAR(50)           not null,
   constraint PK_TIPO_TRABAJADOR primary key (TIPO_TRABAJADOR_ID)
);

/*==============================================================*/
/* Table: TRABAJADOR                                            */
/*==============================================================*/
create table TRABAJADOR (
   TRABAJADOR_ID        SERIAL               not null,
   TIPO_TRABAJADOR_ID   INT                  not null,
   TRABAJADOR_CEDULA    CHAR(10)             not null,
   TRABAJADOR_NOMBRE    CHAR(50)             not null,
   TRABAJADOR_APELLIDO  CHAR(50)             not null,
   TRABAJADOR_GENERO    CHAR(50)             not null,
   TRABAJADOR_DIRECCION CHAR(50)             not null,
   TRABAJADOR_TELEFONO  INT                  not null,
   TRABAJADOR_CORREO    CHAR(50)             not null,
   TRABAJADOR_FECHANACIMIENTO DATE           not null,
   TRABAJADOR_FECHA_CONTRATO DATE            not null,
   TRABAJADOR_PAGO_MENSUAL MONEY             not null,
   constraint PK_TRABAJADOR primary key (TRABAJADOR_ID)
);

alter table CITA
   add constraint FK_CITA_PACIENTE__PACIENTE foreign key (PACIENTE_ID)
      references PACIENTE (PACIENTE_ID)
      on delete cascade on update cascade;

alter table CITA
   add constraint FK_CITA_TIENE_TIPO_CIT foreign key (TIPO_CITA_ID)
      references TIPO_CITA (TIPO_CITA_ID)
      on delete cascade on update cascade;

alter table CITA
   add constraint FK_CITA_TRABAJADO_TRABAJAD foreign key (TRABAJADOR_ID)
      references TRABAJADOR (TRABAJADOR_ID)
      on delete cascade on update cascade;

alter table CITA_CASO
   add constraint FK_CITA_CAS_TENER2_CITA foreign key (CITA_ID)
      references CITA (CITA_ID)
      on delete cascade on update cascade;

alter table CITA_CASO
   add constraint FK_CITA_CAS_TENER3_CASO foreign key (IDENTIFICACION_CASO_ID)
      references CASO (IDENTIFICACION_CASO_ID)
      on delete cascade on update cascade;

alter table ENTREGA
   add constraint FK_ENTREGA_CUIDADOR__TRABAJAD foreign key (TRABAJADOR_ID)
      references TRABAJADOR (TRABAJADOR_ID)
      on delete cascade on update cascade;

alter table ENTREGA
   add constraint FK_ENTREGA_PACIENTE__PACIENTE foreign key (PACIENTE_ID)
      references PACIENTE (PACIENTE_ID)
      on delete cascade on update cascade;

alter table MEDICAMENTO_CITA
   add constraint FK_ESTAR_ESTAR_CITA foreign key (CITA_ID)
      references CITA (CITA_ID)
      on delete cascade on update cascade;

alter table MEDICAMENTO_CITA
   add constraint FK_ESTAR_ESTAR2_MEDICAME foreign key (MEDICAMENTO_ID)
      references MEDICAMENTO (MEDICAMENTO_ID)
      on delete cascade on update cascade;

alter table MEDICAMENTO_ENTREGA
   add constraint FK_MEDICAME_MEDICAMEN_MEDICAME foreign key (MEDICAMENTO_ID)
      references MEDICAMENTO (MEDICAMENTO_ID)
      on delete cascade on update cascade;

alter table MEDICAMENTO_ENTREGA
   add constraint FK_MEDICAME_MEDICAMEN_ENTREGA foreign key (ENTREGA_ID)
      references ENTREGA (ENTREGA_ID)
      on delete cascade on update cascade;

alter table TRABAJADOR
   add constraint FK_TRABAJAD_TIPO_DE_T_TIPO_TRA foreign key (TIPO_TRABAJADOR_ID)
      references TIPO_TRABAJADOR (TIPO_TRABAJADOR_ID)
      on delete cascade on update cascade;
	  

/*==============================================================*/
/* INSERT: Tipo_Cita                                            */
/*==============================================================*/

Insert into TIPO_CITA values(DEFAULT, 'Terapia');
Insert into TIPO_CITA values(DEFAULT, 'Consulta');
Insert into TIPO_CITA values(DEFAULT, 'Emergencia Medica');


/*==============================================================*/
/* INSERT: Caso                                                 */
/*==============================================================*/

/*TRATAMIENTOS*/
Insert into Caso values(DEFAULT, 'Psicoterapia');
Insert into Caso values(DEFAULT, 'comunicacion social');
Insert into Caso values(DEFAULT, 'terapia ocupacional');
Insert into Caso values(DEFAULT, 'refuerzo comunitario');
Insert into Caso values(DEFAULT, 'autogobierno');
Insert into Caso values(DEFAULT, 'clase cognitiva-conductual');
Insert into Caso values(DEFAULT, 'habilidades sociales');
Insert into Caso values(DEFAULT, 'afrontamiento adictivos');
Insert into Caso values(DEFAULT, 'programa de prevencion de recaidas');


/*==============================================================*/
/* INSERT: Caso                                                 */
/*==============================================================*/
/*SIGNOS MEDICOS*/
Insert into Caso values(DEFAULT, 'Sangrado');
Insert into Caso values(DEFAULT, 'Problema respiratorio');
Insert into Caso values(DEFAULT, 'Dolor torácico');
Insert into Caso values(DEFAULT, 'Asfixia');
Insert into Caso values(DEFAULT, 'Expectoración o vómito con sangre');
Insert into Caso values(DEFAULT, 'Desmayo o pérdida del conocimiento');
Insert into Caso values(DEFAULT, 'Lesión en la cabeza o en la columna');
Insert into Caso values(DEFAULT, 'Fiebre');
	  
	  
	  
/*==============================================================*/
/* INSERT: Tipo_Trabajador                                      */
/*==============================================================*/ 

Insert into Tipo_trabajador values(DEFAULT, 'Seguridad');
Insert into Tipo_trabajador values(DEFAULT, 'Cuidador');
Insert into Tipo_trabajador values(DEFAULT, 'Doctor');
Insert into Tipo_trabajador values(DEFAULT, 'Terapeuta');

/*==============================================================*/
/* INSERT: Trabajador                                           */
/*==============================================================*/
/*2 seguridad*/
Insert into Trabajador values(DEFAULT, 1, '1258946876', 'Mauricio Jorge', 'Hernandez Blanco', 'Masculino', 'Leonidas Proaño', 0995684287, 'MauricioHernandez@hotmail.com', '1987/08/15', '2020/09/25', 650);
Insert into Trabajador values(DEFAULT, 1, '1258978895', 'Juan Pablo', 'Gutierrez Salcedo', 'Masculino', 'Costa Azul', 0995684234, 'JuanPablo@hotmail.com', '1987/10/15', '2020/10/15', 650);
/*5 cuidadores*/
Insert into Trabajador values(DEFAULT, 2, '1258374182', 'Maria Fernanda', 'Gonzales Cruz', 'Feminino', 'Leonidas Proaño', 0998545762, 'MariaGonzales@hotmail.com', '2000/11/01', '2020/10/10', 450);
Insert into Trabajador values(DEFAULT, 2, '1258314756', 'Daniel Alejandro', 'Mera Pilay', 'Masculino', 'Portoviejo', 0998857362, 'DanielPilay@hotmail.com', '2000/08/05', '2020/10/10', 450);
Insert into Trabajador values(DEFAULT, 2, '1258347852', 'Maria Soledad', 'Martinez Alvarado', 'Feminino', 'Leonidas Proaño', 0998558721, 'SolMartinez@hotmail.com', '2000/06/12', '2020/10/10', 450);
Insert into Trabajador values(DEFAULT, 2, '1258315789', 'Alex Kevin', 'Martinez Montenegro', 'Masculino', 'Pradera', 0998545758, 'AlexMartinez@hotmail.com', '2000/11/01', '2020/10/05', 450);
Insert into Trabajador values(DEFAULT, 2, '1258387594', 'Yoselin Ana', 'Bermudez Yanez', 'Feminino', 'Leonidas Proaño', 0998598789, 'AnaBermudez@hotmail.com', '2000/12/15', '2020/10/05', 450);
/*3 doctores*/
Insert into Trabajador values(DEFAULT, 3, '1258374182', 'Alisson Sthefany', 'Moreira Cepeda', 'Feminino', 'Costa Azul', 0998556987, 'AlissonMoreira@gmail.com', '1989/11/01', '2020/09/10', 700);
Insert into Trabajador values(DEFAULT, 3, '1258377851', 'Eduador Jesus', 'Montemayor Cisnero', 'Masculino', 'Costa Azul', 0998552345, 'EduardoMontemayor@gmail.com', '1989/09/12', '2020/09/10', 700);
Insert into Trabajador values(DEFAULT, 3, '1258378524', 'Angela Maria', 'Palacios Cevallos', 'Feminino', 'Portoviejo', 0998558957, 'AngelaPalacios@gmail.com', '1987/04/15', '2020/09/10', 700);
/*3 terapeutas*/
Insert into Trabajador values(DEFAULT, 4, '1258857696', 'Ana Maria', 'Palacios Mera', 'Feminino', 'Portoviejo', 0998548569, 'AnaMaria@gmail.com', '1990/09/15', '2020/09/10', 600);
Insert into Trabajador values(DEFAULT, 4, '1258857598', 'Luis Angel', 'Martinez Zambrano', 'Masculino', '24 de junio', 0998587521, 'LuisAngel@gmail.com', '1991/10/15', '2020/09/10', 600);
Insert into Trabajador values(DEFAULT, 4, '1258857418', 'Ana Belen', 'Palacios NosequexD', 'Feminino', 'Portoviejo', 0998574187, 'AnaBelen@gmail.com', '1989/11/15', '2020/09/10', 600);


/*==============================================================*/
/* INSERT: Paciente                                             */
/*==============================================================*/

/*5 pacientes*/
Insert into Paciente values(DEFAULT, '1728821081' ,'Brando Rafael', 'Mero Cepeda', 'Masculino','Leonidas Proaño', 0963326490, 'shoper687@gmail.com','2000/08/19', '2020/10/20', 0, 'Proceso', 'drogadiccion', 'A001', 'ibuprofeno');
Insert into Paciente values(DEFAULT, '1728821856' ,'Laura Maria', 'Pareja Borja', 'Femenino','Ibague', 0963587419, 'Lauranakin27@gmail.com','2002/12/04', '2020/10/20', 0, 'Proceso', 'drogadiccion', 'A002', 'lacteos');
Insert into Paciente values(DEFAULT, '1728828547' ,'Mario David', 'Ubilla Reyes', 'Masculino','EnsucasitaUwU', 0993899824, 'Elwhasontdrogadicto@gmail.com','2000/11/12', '2020/10/22', 0, 'Proceso', 'drogadiccion', 'A003');
Insert into Paciente values(DEFAULT, '1312698424' ,'Jose Abel', 'Cedeño Mendoza', 'Masculino','Portoviejo', 0988916451, 'e1312698424@live.uleam.edu.ec','2000/02/10', '2020/10/25', 3, 'Proceso', 'Alcoholismo', 'A004');
Insert into Paciente values(DEFAULT, '1728875911' ,'Luis Joel', 'Mendez Loor', 'Masculino','Santa ana', 0983334657, 'JoelMendez@gmail.com','2000/10/11', '2020/10/26', 0, 'Proceso', 'Alcoholismo', 'A005', 'naxopreno');

/*==============================================================*/
/* INSERT: Medicamento                                          */
/*==============================================================*/	  

/*Parches para drogadictos y alcoholicos*/
Insert into medicamento values(DEFAULT, 'M001', 'chicle nicotina', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M002', 'pastillas nicotina', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M003', 'butirilcolinesterasa', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M004', 'aerosoloes', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M005', 'transdérmico CBD', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M006', 'Vareniclina', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M007', 'Bupropian', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M008', 'Naltrexona', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M009', 'Topiramato', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M010', 'Acamprosato', 'Parches', 50);
Insert into medicamento values(DEFAULT, 'M011', 'Disulfiran', 'Parches', 50);

/*Medicamentos generales*/
Insert into medicamento values(DEFAULT, 'M012', 'Alcohol antiseptico', 'Medicina general', 50);
Insert into medicamento values(DEFAULT, 'M013', 'Paracetamol', 'Analgesico, Antipiréticos', 50);
Insert into medicamento values(DEFAULT, 'M014', 'Ibuprofeno', 'antiflamatorio', 50);
Insert into medicamento values(DEFAULT, 'M015', 'Aspirina', 'antiflamatorio', 50);
Insert into medicamento values(DEFAULT, 'M016', 'Omeprazol', 'Antiácidos y antiulcerosos', 50);
Insert into medicamento values(DEFAULT, 'M017', 'Cetirizina', 'Antialergico', 50);
Insert into medicamento values(DEFAULT, 'M018', 'Fexofenadina', 'Antialergico', 50);
Insert into medicamento values(DEFAULT, 'M019', 'Amoxicilina', 'Antiinfeccion', 50);
Insert into medicamento values(DEFAULT, 'M020', 'Loratadina', 'Antialergico', 50);
Insert into medicamento values(DEFAULT, 'M021', 'Cefalexina', 'Antiinfeccion', 50);
Insert into medicamento values(DEFAULT, 'M022', 'Albuterol', 'ProAir HFA, Proventil HFA, Ventolin HFA', 50);
Insert into medicamento values(DEFAULT, 'M023', 'Levalbuterol', 'Xopenex HFA', 50);
Insert into medicamento values(DEFAULT, 'M024', 'Gasa esteril', 'Medicina general', 50);
Insert into medicamento values(DEFAULT, 'M025', 'Vendas adhesivas', 'Medicina general', 50);



/*==============================================================*/
/* INSERT: Entrega                                              */
/*==============================================================*/	

Insert into Entrega values(DEFAULT,3, 1, '2020/10/21', '10:00:00');
Insert into Entrega values(DEFAULT,4, 2, '2020/10/21', '10:00:00');
Insert into Entrega values(DEFAULT,3, 1, '2020/10/21', '20:00:00');
Insert into Entrega values(DEFAULT,4, 2, '2020/10/21', '20:00:00');

Insert into Entrega values(DEFAULT,3, 1, '2020/10/22', '10:00:00');
Insert into Entrega values(DEFAULT,4, 2, '2020/10/22', '10:00:00');
Insert into Entrega values(DEFAULT,3, 1, '2020/10/22', '20:30:00');
Insert into Entrega values(DEFAULT,4, 2, '2020/10/22', '20:30:00');

Insert into Entrega values(DEFAULT,5, 3, '2020/10/23', '10:00:00');
Insert into Entrega values(DEFAULT,5, 3, '2020/10/23', '20:00:00');
Insert into Entrega values(DEFAULT,5, 3, '2020/10/23', '10:45:00');
Insert into Entrega values(DEFAULT,5, 3, '2020/10/23', '20:45:00');

Insert into Entrega values(DEFAULT,3, 1, '2020/10/23', '10:00:00');
Insert into Entrega values(DEFAULT,4, 2, '2020/10/23', '10:00:00');
Insert into Entrega values(DEFAULT,3, 1, '2020/10/23', '20:00:00');
Insert into Entrega values(DEFAULT,4, 2, '2020/10/23', '20:00:00');

Insert into Entrega values(DEFAULT, 5, 3,'2020/10/25', '17:32:00');

/*==============================================================*/
/* INSERT: Medicamento_entrega                                  */
/*==============================================================*/	

/*2020/10/21*/
Begin;

Insert into Medicamento_entrega values(7,1); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M007';
COMMIT;

Begin;

Insert into Medicamento_entrega values(8,2); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M008';
COMMIT;

Begin;

Insert into Medicamento_entrega values(7,3); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M007';
COMMIT;

Begin;

Insert into Medicamento_entrega values(8,4); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M008';
COMMIT;
/*2020/10/22*/
Begin;

Insert into Medicamento_entrega values(2,5); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M002';
COMMIT;

Begin;

Insert into Medicamento_entrega values(2,6); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M002';
COMMIT;

Begin;

Insert into Medicamento_entrega values(3,7); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M003';
COMMIT;
Begin;

Insert into Medicamento_entrega values(3,8); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M003';
COMMIT;
/*2020/10/23*/
Begin;
Insert into Medicamento_entrega values(15,9); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M015';
COMMIT;
Begin;
Insert into Medicamento_entrega values(15,10); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M015';
COMMIT;

Begin;
Insert into Medicamento_entrega values(16,11); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M016';
COMMIT;

Begin;
Insert into Medicamento_entrega values(16,12); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M016';
COMMIT;
/*LB*/
Begin;
Insert into Medicamento_entrega values(3,13); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M003';
COMMIT;

BegiN;
Insert into Medicamento_entrega values(3,14); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M003';
COMMIT;
Begin;
Insert into Medicamento_entrega values(2,15); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M002';
COMMIT;
Begin;
Insert into Medicamento_entrega values(2,16); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M002';
COMMIT;
/*2020/10/25*/
Begin;
Insert into Medicamento_entrega values(1,17); 
update Medicamento set medicamento_cantidad = medicamento_cantidad - 1
Where MEDICAMENTO_CODIGO = 'M001';
COMMIT;

/*==============================================================*/
/* INSERT: CITA                                                 */
/*==============================================================*/	

/*Terapias*/

Insert into Cita values(DEFAULT, 11, 1, 1, 'Tiene descontrol en sus pensamientos', '2020/10/21', '11:00:00', '13:00:00', 'T1');
Insert into Cita values(DEFAULT, 11, 1, 1, 'Necesita mejorar sus habilidades sociales', '2020/10/21', '14:00:00', '16:00:00', 'T1');
Insert into Cita values(DEFAULT, 12, 2, 1, 'Es agresiva pasiva', '2020/10/21', '08:00:00', '10:00:00', 'T2');
Insert into Cita values(DEFAULT, 12, 2, 1, 'Tiene indicios de doble personalidad', '2020/10/21', '14:00:00', '16:00:00', 'T2');

Insert into Cita values(DEFAULT, 13, 1, 1, 'Necesita tener afrontamientos con la adiccion que tiene', '2020/10/22', '08:00:00', '10:00:00', 'T3');
Insert into Cita values(DEFAULT, 13, 1, 1, 'Tiene pensamientos malos para el mismo', '2020/10/22', '14:00:00', '16:00:00', 'T3');
Insert into Cita values(DEFAULT, 11, 2, 1, 'Tiene multiples alucinaciones', '2020/10/22', '08:00:00', '10:00:00', 'T1');
Insert into Cita values(DEFAULT, 11, 2, 1, 'Cambia de actitud constantemente, extremo caso de bipolaridad', '2020/10/22', '14:00:00', '16:00:00', 'T1');

Insert into Cita values(DEFAULT, 11, 1, 1, 'Esta presentando cambios de personalidad', '2020/10/23', '08:00:00', '10:00:00', 'T3');
Insert into Cita values(DEFAULT, 11, 2, 1, 'Tiene ansiedad continuamente', '2020/10/23', '08:00:00', '10:00:00', 'T1');
Insert into Cita values(DEFAULT, 12, 3, 1, 'Tiene una gran ansiedad por motivo de las drogas', '2020/10/23', '08:00:00', '10:00:00', 'T2');

Insert into Cita values(DEFAULT, 11, 1, 1, 'Necesita ocupar tiempo en actividades sanas', '2020/10/23', '14:00:00', '16:00:00', 'T3');
Insert into Cita values(DEFAULT, 11, 2, 1, 'Necesita distraer la mente en juegos recreativos', '2020/10/23', '14:00:00', '16:00:00', 'T1');
Insert into Cita values(DEFAULT, 12, 3, 1, 'Necesita comunicacion social', '2020/10/23', '14:00:00', '16:00:00', 'T2');


/*CONSULTA*/
Insert into Cita values(DEFAULT, 8, 1, 2, 'Presenta una fiebre alta', '2020/10/23', '20:00:00', '21:00:00', 'A1');
Insert into Cita values(DEFAULT, 9, 2, 2, 'La paciente sufrió un desmayo', '2020/10/23', '17:00:00', '19:00:00', 'A2');


/*EMERGENCIA*/
Insert into Cita values(DEFAULT, 10, 3, 3, 'El paciente quiso suicidarse, asfixiándose', '2020/10/23', '23:00:00', '01:00:00', 'A3');
Insert into Cita values(DEFAULT, 8, 2, 3, 'Se generó cortadas en los brazos, cerca de las venas', '2020/10/23', '22:00:00', '10:00:00', 'A2');



/*==============================================================*/
/* INSERT: CITA_CASO                                            */
/*==============================================================*/	
/*tratamientos*/
Insert into Cita_caso values(1,1);
Insert into Cita_caso values(2,2);
Insert into Cita_caso values(3,6);
Insert into Cita_caso values(4,1);
Insert into Cita_caso values(5,8);
Insert into Cita_caso values(6,4);
Insert into Cita_caso values(7,1);
Insert into Cita_caso values(8,1);
Insert into Cita_caso values(9,1);
Insert into Cita_caso values(10,8);
Insert into Cita_caso values(11,9);
Insert into Cita_caso values(12,3);
Insert into Cita_caso values(13,3);
Insert into Cita_caso values(14,2);
/*casos de consulta*/
Insert into Cita_caso values(15,17);
Insert into Cita_caso values(16,15);
/*Casos de emergencia*/
Insert into Cita_caso values(17,13);
Insert into Cita_caso values(18,10);


/*==============================================================*/
/* INSERT: MEDICAMENTO_CITA                                     */
/*==============================================================*/	


Insert into Medicamento_cita values(15,13);
Insert into Medicamento_cita values(18,12);
Insert into Medicamento_cita values(18,24);
Insert into Medicamento_cita values(18,25);
Insert into Medicamento_cita values(18,13);






















































	  
	  
	  
	  
	  
	 	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  

