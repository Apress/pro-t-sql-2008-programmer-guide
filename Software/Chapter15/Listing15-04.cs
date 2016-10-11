// This is a code snippet, it will not run as is without additional code to
// declare the appropriate namespaces and establish a database connection.

SqlCommand command = new SqlCommand
  (
    "CREATE TABLE #temp " +
    "  ( " +
    "    Id INT NOT NULL PRIMARY KEY, " +
    "    Name NVARCHAR(50) " +
    "  );", connection
  );
command.ExecuteNonQuery();
