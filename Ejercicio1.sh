db.createCollection("profesores", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "nombre",
        "edad",
        "especialidad",
        "experiencia"
      ],
      properties: {
        nombre: {
          bsonType: "string",
          minLength: 2,
          description: "Debe tener al menos 2 caracteres el nombre del profesor"
        },
        edad: {
          bsonType: "int",
          minimum: 25,
          maximum: 70,
          description: "Debe tener entre 25 y 70 años la edad del profesor"
        },
        especialidad: {
          bsonType: "string",
          description: "Debe ingresar la especialidad del profesor"
        },
        experiencia: {
            bsonType: "int",
            minimum: 0,
          description: "No pueden ser negativos los años de experiencia"
        }
      }
    }
  }
});

db.profesores.insertMany([
    {
        nombre:"Sandra",
        edad: 53,
        especialidad: "Analisis Matematico",
        experiencia: 20,
        email: "sandra@gmail.com",
        departamento: "Matematica",
        salario: 800000,
        activo: true
    },
    {
        nombre:"Carlos",
        edad: 70,
        especialidad: "Programacion estructurada",
        experiencia: 30,
        email: "carlos@gmail.com",
        departamento: "Informatica",
        salario: 750000,
        activo: false
    },
    {
        nombre: "Luis",
        edad: 25,
        especialidad: "Fisica",
        experiencia: 2,
        email: "luis@gmail.com",
        departamento: "Ciencias",
        salario: 700000,
        activo: false
    },
    {
        nombre: "Ana",
        edad: 25,
        especialidad: "Educacion Fisica",
        experiencia: 5,
        email: "ana@gmail.com",
        departamento: "Deporte",
        salario: 900000,
        activo: true
    },
    {
        nombre: "Fabian",
        edad: 69,
        especialidad: "Algebra",
        experiencia: 40,
        email: "fabian@gmail.com",
        departamento: "Matematica",
        salario: 950000,
        activo: false
    }
])

db.profesores.find({experiencia: {$gt: 15}})

db.profesores.aggregate([
  {
    $match: { activo: true }
  },
  {
    $group: {
      _id: null,
      promedioSalario: { $avg: "$salario" },
      promedioEdad: { $avg: "$edad" },
      promedioExperiencia: { $avg: "$experiencia" }
    }
  }
])

db.profesores.aggregate([
    {
    $group: {
      _id: "$departamento",
      numeroProfesores: { $sum: 1 },
      experienciaTotal: { $sum: "$experiencia" },
      promedioSalario: { $avg: "$salario" },
      nombres: { $push: "$nombre" }
    }
  }
])
