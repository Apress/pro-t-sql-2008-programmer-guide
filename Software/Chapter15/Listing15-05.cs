// This is a code snippet, it will not run as is without additional code to
// declare the appropriate namespaces and establish a database connection.

SqlCommand command = new SqlCommand
  (
    "SELECT COUNT(*) " +
    "FROM Person.Person;", sqlcon
  );
Object count = command.ExecuteScalar();

