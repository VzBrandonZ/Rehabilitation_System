/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     15/12/2020 16:49:30                          */
/*==============================================================*/


drop table CASO;

drop table CITA;

drop table CITA_CASO;

drop table ENTREGA;

drop table ESTAR;

drop table MEDICAMENTO;

drop table MEDICAMENTO_ENTREGA;

drop table PACIENTE;

drop table TIPO_CITA;

drop table TIPO_TRABAJADOR;

drop table TRABAJADOR;

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
   CITA_DESCRIPCION     CHAR(50)             not null,
   CITA_FECHA           DATE                 not null,
   CITA_HORA            TIME                 not null,
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
   MEDICAMENTO_ID       CHAR(5)             not null,
   constraint PK_ESTAR primary key (CITA_ID, MEDICAMENTO_ID)
);

/*==============================================================*/
/* Table: MEDICAMENTO                                           */
/*==============================================================*/
create table MEDICAMENTO (
   MEDICAMENTO_ID       CHAR(5)              not null,
   MEDICAMENTO_NOMBRE   CHAR(50)             not null,
   MEDICAMENTO_TIPO     CHAR(50)             not null,
   MEDICAMENTO_CANTIDAD INT                  not null,
   constraint PK_MEDICAMENTO primary key (MEDICAMENTO_ID)
);

/*==============================================================*/
/* Table: MEDICAMENTO_ENTREGA                                   */
/*==============================================================*/
create table MEDICAMENTO_ENTREGA (
   MEDICAMENTO_ID       CHAR(5)              not null,
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

/*SIGNOS MEDICOS*/
/*==============================================================*/
/* INSERT: Caso                                                 */
/*==============================================================*/

Insert into Caso values(DEFAULT, 'Sangrado');
Insert into Caso values(DEFAULT, 'Problema respiratorio');
Insert into Caso values(DEFAULT, 'Dolor torácico');
Insert into Caso values(DEFAULT, 'Asfixia');
Insert into Caso values(DEFAULT, 'Expectoración o vómito con sangre');
Insert into Caso values(DEFAULT, 'Desmayo o pérdida del conocimiento');
Insert into Caso values(DEFAULT, 'Lesión en la cabeza o en la columna');
Insert into Caso values(DEFAULT, 'afrontamiento adictivos');
Insert into Caso values(DEFAULT, 'programa de prevencion de recaidas');
	  
	  
	  
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



	  
	  
	  
	  
	  
	  
	 	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  

