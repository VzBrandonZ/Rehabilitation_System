													/*==============================================================*/
													/* 						  CONSULTAS                             */
													/*==============================================================*/	



/*–	¿Qué cantidad de días han asistido los pacientes a sus tratamientos?*/

Select 
	Paciente.Paciente_cedula AS Cedula,
	Paciente.Paciente_nombre ||' '||Paciente.Paciente_Apellido AS Nombre_Completo,
	Tipo_cita.Tipo_cita_nombre AS Tipo_de_cita,
	Count(distinct Cita.Cita_fecha) AS Dias
from Paciente INNER JOIN Cita ON Paciente.Paciente_id = Cita.Paciente_id
INNER JOIN Tipo_cita ON Cita.Tipo_cita_id = Tipo_cita.Tipo_cita_id
Where Tipo_cita.Tipo_cita_nombre = 'Terapia'
Group By Cedula, Nombre_completo, Tipo_de_cita;


/*–	¿Cuántas personas han reingresado al Centro nuevamente?*/
Select * from Paciente
Where Paciente_reingreso > 0;


/*–	¿Cuál es la cantidad de medicamentos administrada a cada paciente, y que cuidador se la administra?*/

Select 
	Paciente.Paciente_nombre ||' '||Paciente.Paciente_Apellido AS Nombre_Paciente,
	Trabajador.Trabajador_nombre ||' '||Trabajador.Trabajador_apellido As Nombre_Cuidador,
	count(Entrega.Paciente_id) AS Cantidad
from Paciente INNER JOIN Entrega ON Paciente.Paciente_id = Entrega.Paciente_id
INNER JOIN Trabajador ON Entrega.Trabajador_id = Trabajador.Trabajador_id
Group By Nombre_Paciente, Nombre_Cuidador;

/*–	¿Cuáles son los pacientes que han ido a un consultorio médico, por cual doctor han sido atendido y cuál es la causa?*/
Select
	Paciente.Paciente_nombre ||' '||Paciente.Paciente_Apellido AS Nombre_Paciente,
	Trabajador.Trabajador_nombre ||' '||Trabajador.Trabajador_apellido As Nombre_Doctor,
	Cita.Cita_oficina AS Consultorio,
	Cita.Cita_descripcion AS Causa
From Paciente INNER JOIN Cita ON Paciente.Paciente_id = Cita.Paciente_id
INNER JOIN Tipo_cita ON Cita.Tipo_cita_id = Tipo_cita.Tipo_cita_id
INNER JOIN Trabajador ON Cita.Trabajador_id = Trabajador.Trabajador_id
Where Tipo_cita.Tipo_cita_nombre = 'Consulta' or Tipo_cita.Tipo_cita_nombre = 'Emergencia Medica';

/*Cantidad de veces que han asistido los pacientes a sus tratamientos*/

Select
	Paciente.Paciente_cedula AS Cedula,
	Paciente.Paciente_nombre ||' '||Paciente.Paciente_Apellido AS Nombre_Completo,
	Tipo_cita.Tipo_cita_nombre AS Tipo_de_cita,
	Count( Cita.Cita_fecha) AS Asistencias_a_terapias
from Paciente INNER JOIN Cita ON Paciente.Paciente_id = Cita.Paciente_id
INNER JOIN Tipo_cita ON Cita.Tipo_cita_id = Tipo_cita.Tipo_cita_id
Where Tipo_cita.Tipo_cita_nombre = 'Terapia'
Group By Cedula, Nombre_completo, Tipo_de_cita;

