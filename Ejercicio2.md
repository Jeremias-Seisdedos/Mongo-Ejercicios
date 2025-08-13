# Ejercicio 2: Sistema de Cursos y Matriculaciones
## Diseña una colección para administrar los cursos y su proceso de inscripción.
---

### Requisitos:
1. Crear una colección llamada cursos e insertar al menos dos documentos 
    con los siguientes campos:
    - codigo (ej. "MAT101")
    - nombre
    - creditos
    - profesorId (relación con la colección profesores)
    - horario: un objeto con los días y el horario del curso.
    - cupoMaximo
    - inscritos: un arreglo inicialmente vacío.

**Codigo para la colección:**
```mongodb
db.createCollection("cursos")

db.cursos.insertMany([
    {
        codigo: "MAT101",
        nombre: "Matematicas I",
        creditos: 4,
        profesorId: ObjectId("689cd9a6f00c71930289b051"),
        horario: {
            lunes: "10:00-12:00",
            miercoles: "10:00-12:00"
        },
        cupoMaximo: 30,
        inscriptos: []
    },
    {
        codigo: "FIS201",
        nombre: "Fisica II",
        creditos: 5,
        profesorId: ObjectId("689cd9a6f00c71930289b053"),
        horario: {
            martes: "14:00-16:00",
            jueves: "14:00-16:00"
        },
        cupoMaximo: 25,
        inscriptos: []
    },
    {
        codigo: "INF301",
        nombre: "Programacion Estructurada",
        creditos: 3,
        profesorId: ObjectId("689cd9a6f00c71930289b052"),
        horario: {
            viernes: "08:00-10:00"
        },
        cupoMaximo: 20,
        inscriptos: []
    }
])
```
---
2. Matricular un alumno en un curso 
    agregando al arreglo inscritos un objeto con:
    - alumnoId
    - fechaInscripcion (fecha actual)
    - estado (ej. "activo")

```mongodb
db.cursos.updateOne(
    {codigo: "INF301"},
    {
        $push:{
                inscriptos: {
                alumnoId: ObjectId("689ce4e1f00c71930289b058"),
                fechaInscripcion: new Date(),
                estado: "activo"
                }
        }
    }
)
```

---

3. Consultar los cursos con cupos disponibles, calculando el número de cupos restantes y mostrando solo aquellos con disponibilidad.

**Codigo para la consulta:**
```mongodb
db.cursos.aggregate([
   {
        $project: {
            codigo: 1,
            nombre: 1,
            cupoMaximo: 1,
            inscriptos: { $size: "$inscriptos" },
            cuposRestantes: { $subtract: ["$cupoMaximo", { $size: "$inscriptos" }] }
        }
    },
    {
        $match: {
            cuposRestantes: { $gt: 0 }
        }
    }
])
```
