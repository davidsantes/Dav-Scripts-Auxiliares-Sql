# ScriptsAuxiliaresSql

Scripts SQL para poder ayudar en las labores de soporte, explotación de datos, y conocimiento de la calidad de una base de datos SQL Server.

Estos scripts están clasificados en:
* **Data Definition Language - DDL**: Scripts que se utilizan para definir la estructura y las características de los objetos de la base de datos, como tablas, índices, procedimientos almacenados, etc.
* **Data Manipulation Language - DML**: Scripts que se utilizan para manipular los datos almacenados en la base de datos, como insertar, actualizar, eliminar, etc.

## Control de versiones 📋
| Versión | Fecha | Autor   | Observaciones |
| ------- | ------- | ------- | ------------- |
| 0.1     | 07/04/2024 | David S | Versión inicial   |

## Índice

1. **[Data Definition Language - DDL](#DDL)**
2. **[Data Manipulation Language - DML](#DML)**

## Data Definition Language - DDL 📋 <a name="DDL"></a>

Dentro de la carpeta ```DataDefinitionLanguage-DDL```, se incluyen:
1. Scripts Sql que permiten explotar la calidad de una base de datos a nivel de DDL. Por ejemplo:
    * Si existen procedimientos almacenados con una longitud superior a x líneas.
    * Si existen procedimientos almacenados con sql dinámino.
2. Script sql de ayuda a la hora de creación de una base de datos, por ejemplo:
    * Cambio del owner en un diagrama (muchas veces cuando se crea, se crea con el esquema del usuario, por lo que otros técnicos no lo pueden ver).
    * Ejemplo de creación de una tabla de auditoría para registrar cualquier cambio de tipo DDL (generaría un histórico de cambios en la base de datos a nivel de esquema).

## Data Manipulation Language - DML 📋 <a name="DML"></a>

Dentro de la carpeta ```DataManipulationLanguage-DML```, se incluyen:
1. Scripts Sql para iterar un conjunto de datos. Puede ser útil para temas de soporte (actualización de datos), o exportaciones de datos muy complejas.

## Autores ✒️
* **David Santesteban** - [davidsantes](https://github.com/davidsantes)

## Agradecimientos 🎁

* **Itziar Arrieta** por la colaboración en scripts.
* A cualquiera que me invite a una cerveza 🍺.

---